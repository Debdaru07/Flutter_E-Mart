import logging
import fitz

def extract_text_from_pdf(file):
    """
    Extracts text from a PDF file using PyMuPDF.
    Returns a structured dictionary with page-wise text content.
    """
    try:
        pdf_document = fitz.open(stream=file.read(), filetype="pdf")
        extracted_text = {}

        for page_number in range(len(pdf_document)):
            page = pdf_document[page_number]
            text = page.get_text("text")  # Extract plain text
            if text:
                extracted_text[page_number + 1] = text

        pdf_document.close()
        return extracted_text if extracted_text else {}
    except Exception as e:
        logging.error(f"Error extracting text from PDF: {str(e)}")
        return {}