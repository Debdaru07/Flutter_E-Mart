import logging
import fitz
import pytesseract
from indic_transliteration import sanscript
from pdf2image import convert_from_path
from langdetect import detect


def is_text_based_pdf(pdf_document):
    """ Check if the PDF has copy-pastable text """
    for page in pdf_document:
        text = page.get_text("text").strip()
        if text:
            return True
    return False

def extract_text_from_pdf(file):
    """
    Extracts text from a PDF file using PyMuPDF.
    Returns a structured dictionary with page-wise text content.
    """
    try:
        pdf_document = fitz.open(stream=file.read(), filetype="pdf")
        extracted_text = {}
        print("Hindi... Newspaper PDF ...")
        # Check if the PDF has selectable text
        if is_text_based_pdf(pdf_document):
            for page_number in range(len(pdf_document)):
                page = pdf_document[page_number]
                text = page.get_text("text", flags=fitz.TEXT_PRESERVE_LIGATURES | fitz.TEXT_PRESERVE_WHITESPACE | fitz.TEXT_DEHYPHENATE)  # Extract plain text
                fonts = page.get_fonts()

                krutidev_fonts = any('KrutiDev' in font[3] or 'Devanagari' for font in fonts)
                if krutidev_fonts and text.strip() and not all(ord(c) < 32 or ord(c) > 126 for c in text if c):
                    try:
                        text = sanscript.transliterate(text, sanscript.KRUTIDEV, sanscript.DEVANAGARI)
                    except Exception as e:
                        print(f"KrutiDev conversion failed on page {page_number + 1}: {str(e)}")
                
                if text.strip():
                    extracted_text[page_number + 1] = text
                
        else:
            print("No selectable text found. Applying OCR...")
            images = convert_from_path(file.name)  # Convert PDF pages to images
            for page_number, img in enumerate(images, start=1):
                ocr_text = pytesseract.image_to_string(img, lang="eng+hin+tam+tel+kan+mal+guj+mar+beng")  # Add other languages if needed
                if ocr_text.strip():
                    extracted_text[page_number] = ocr_text


        pdf_document.close()
        return extracted_text if extracted_text else {}
    except Exception as e:
        logging.error(f"Error extracting text from PDF: {str(e)}")
        return {}