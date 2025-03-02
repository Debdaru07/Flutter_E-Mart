import logging
import re
import spacy

# Load a default English model; we'll switch dynamically for supported languages
try:
    nlp = spacy.load("en_core_web_sm")
except OSError:
    print("English model not found; basic parsing will be used.")

def clean_text(text):
    """Remove extra whitespaces and normalize text."""
    return " ".join(text.split()).strip()

def is_meaningful_content(text):
    """Check if the text resembles meaningful news content."""
    # Criteria: At least 10 words and contains some alphanumeric content
    words = text.split()
    return len(words) >= 10 and any(c.isalnum() for c in text)

def parse_news_content(text, language="en"):
    """Parse the extracted text from a newspaper PDF into a structured format."""
    pages = []
    current_page = {"page_number": None, "sections": {}}
    section_title = None
    author = None
    body = []
    article_title = None

    # Load spaCy model dynamically based on language (if supported)
    global nlp
    language_models = {
        "en": "en_core_web_sm",  # English
        "hi": "xx_ent_wiki_sm",  # Hindi (using multilingual model as proxy)
        "bn": "xx_ent_wiki_sm",  # Bengali (multilingual proxy)
        # Add more mappings as needed; spaCy has limited regional Indian language support
    }
    if language in language_models:
        try:
            nlp = spacy.load(language_models[language])
        except OSError:
            print(f"Model for {language} not found; using basic parsing.")
            nlp = None
    else:
        print(f"Unsupported language {language}; using basic parsing.")
        nlp = None

    # Generic page detection
    page_pattern = re.compile(r"(?:\d+\s*(?:THE|PAGE)|^\d+$)", re.IGNORECASE | re.MULTILINE)
    pages_raw = page_pattern.split(text)

    for i, page_content in enumerate(pages_raw, start=1):
        if not page_content.strip():
            continue

        current_page = {"page_number": i, "sections": {}}
        lines = page_content.splitlines()
        if nlp:
            doc = nlp(page_content)  # Use spaCy for sentence/entity detection if available

        current_section_articles = []

        for line in lines:
            line = clean_text(line)  # Remove extra whitespaces
            if not line:
                continue

            # Section detection: All caps, short lines
            section_match = re.match(r"^([A-Z\s]{2,20})$", line)
            if section_match and line.isupper():
                if section_title and current_section_articles:
                    current_page["sections"][section_title] = {"articles": current_section_articles}
                    current_section_articles = []
                section_title = section_match.group(1)
                author = None
                article_title = None
                body = []
                continue

            # Article title detection: Starts with capital, reasonable length
            title_match = re.match(r"^[A-Z][A-Za-z\s\-\']{5,50}$", line)
            if section_title and not article_title and title_match and not line.isupper():
                if body and article_title and is_meaningful_content("\n".join(body)):
                    current_section_articles.append({
                        "title": clean_text(article_title),
                        "author": clean_text(author) if author else None,
                        "body": clean_text("\n".join(body))
                    })
                article_title = title_match.group(0)
                author = None
                body = []
                continue

            # Author detection: Use spaCy NER if available, else heuristic
            if section_title and article_title and not author:
                if nlp:
                    line_doc = nlp(line)
                    persons = [ent.text for ent in line_doc.ents if ent.label_ == "PERSON"]
                    if persons and len(persons[0].split()) <= 4:
                        author = persons[0]
                        continue
                else:
                    # Fallback: Assume standalone short line after title is author
                    if len(line.split()) <= 4 and line[0].isupper():
                        author = line
                        continue

            # Body collection
            if section_title and article_title and line:
                body.append(line)

        # Save the last article
        if section_title and article_title and body and is_meaningful_content("\n".join(body)):
            current_section_articles.append({
                "title": clean_text(article_title),
                "author": clean_text(author) if author else None,
                "body": clean_text("\n".join(body))
            })
        if section_title and current_section_articles:
            current_page["sections"][section_title] = {"articles": current_section_articles}

        if current_page["sections"]:
            pages.append(current_page)

    return pages

# Example usage
if __name__ == "__main__":
    import json
    logging.debug("Print 1")
    with open("news.txt", "r", encoding="utf-8") as f:
        text = f.read()
    logging.debug("Here")
    structured_content = parse_news_content(text, language="en")
    logging.debug("Print this")
    print(json.dumps(structured_content, indent=2, ensure_ascii=False))