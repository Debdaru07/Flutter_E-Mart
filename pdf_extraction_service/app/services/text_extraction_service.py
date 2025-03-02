import fitz
  
def extract_text_from_pdf(file):
    """
    Extracts text from a PDF file using PyMuPDF.
    Returns a structured dictionary with page-wise text content.
    """
    pdf_document = fitz.open(stream=file.read(), filetype="pdf")
    extracted_text = {}

    for page_number in range(len(pdf_document)):
        page = pdf_document[page_number]
        extracted_text[page_number + 1] = page.get_text("text")  # Extract plain text

    pdf_document.close()
    return extracted_text
