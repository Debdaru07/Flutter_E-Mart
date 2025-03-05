import logging
import fitz
from indic_transliteration import sanscript

def extract_text_from_pdf(file):
    """
    Extracts text from a PDF file using PyMuPDF.
    Returns a structured dictionary with page-wise text content.
    """
    try:
        pdf_document = fitz.open(stream=file.read(), filetype="pdf")
        extracted_text = {}
        print("Hindi... Newspaper PDF ...")
        for page_number in range(len(pdf_document)):
            page = pdf_document[page_number]
            text = page.get_text("text", flags=fitz.TEXT_PRESERVE_LIGATURES | fitz.TEXT_PRESERVE_WHITESPACE | fitz.TEXT_DEHYPHENATE)  # Extract plain text
            fonts = page.get_fonts()

            krutidev_fonts = any('KrutiDev' in font[3] for font in fonts)
            if krutidev_fonts and text.strip() and not all(ord(c) < 32 or ord(c) > 126 for c in text if c):
                try:
                    text = sanscript.transliterate(text, sanscript.KRUTIDEV, sanscript.DEVANAGARI)
                    print(f"Converted KrutiDev to Devanagari on page {page_number + 1}: {text}")
                except Exception as e:
                    print(f"KrutiDev conversion failed on page {page_number + 1}: {str(e)}")
            
            if not text.strip() or all(ord(c) < 32 or ord(c) > 126 for c in text if c):
                print(f"Text extraction failed or binary data detected on page {page_number + 1}: {text}")
            else:
                print(f"Text extraction succeeded for page {page_number + 1}")
            
            if text.strip():
                extracted_text[page_number + 1] = text

        pdf_document.close()
        return extracted_text if extracted_text else {}
    except Exception as e:
        logging.error(f"Error extracting text from PDF: {str(e)}")
        return {}