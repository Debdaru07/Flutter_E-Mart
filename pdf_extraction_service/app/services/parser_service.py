import re

def parse_news_content(text):
    """Parse the extracted text into a structured format."""
    pages = []
    current_page = {"page_number": None, "sections": {}}
    section_title = None
    author = None
    body = []

    page_pattern = re.compile(r"THE ASSAM TRIBUNE, GUWAHATI\s+SUNDAY, MARCH 2, 2025", re.IGNORECASE)
    pages_raw = page_pattern.split(text)[1:]

    for i, page_content in enumerate(pages_raw, start=1):
        current_page = {"page_number": i, "sections": {}}
        lines = page_content.splitlines()

        for line in lines:
            line = line.strip()

            section_match = re.match(r"^\s*([A-Z\s]+)$", line)
            if section_match and line.isupper() and len(line.split()) <= 3:
                if section_title and body:
                    current_page["sections"][section_title] = {
                        "articles": [{"title": section_title, "author": author, "body": "\n".join(body)}]
                    }
                section_title = section_match.group(1).strip()
                author = None
                body = []
                continue

            author_match = re.match(r"^\s*([A-Za-z\s]+)$", line)
            if section_title and not author and author_match and len(line.split()) <= 3 and not line.isupper():
                author = author_match.group(1).strip()
                continue

            if section_title and line:
                body.append(line)

        if section_title and body:
            current_page["sections"][section_title] = {
                "articles": [{"title": section_title, "author": author, "body": "\n".join(body)}]
            }

        pages.append(current_page)

    return pages