import requests
from ..config import Config

def upload_file_to_pdfco(file_content, filename):
    """Uploads a file to PDF.co and returns the URL of the uploaded file."""
    upload_url = "https://api.pdf.co/v1/file/upload"
    headers = {"x-api-key": Config.API_KEY}
    files = {"file": (filename, file_content, "application/pdf")}

    response = requests.post(upload_url, headers=headers, files=files)
    response.raise_for_status()

    data = response.json()
    if not data["error"]:
        return data["url"]
    else:
        raise Exception(f"PDF.co upload failed: {data['message']}")

def extract_text_from_pdf(pdf_url):
    """Converts PDF to text using PDF.co API and returns the extracted text."""
    convert_url = "https://api.pdf.co/v1/pdf/convert/to/text?ocr=true&ocrLanguage=eng"
    headers = {"x-api-key": Config.API_KEY}
    data = {"url": pdf_url}

    response = requests.post(convert_url, headers=headers, data=data)
    response.raise_for_status()

    result = response.json()
    if result.get("error"):
        raise Exception("Text extraction failed")

    text_url = result["url"]
    text_response = requests.get(text_url)
    return text_response.text