import requests
from ..config import Config

def upload_file_to_pdfco(file_content, filename):
    upload_url = "https://api.pdf.co/v1/file/upload"
    headers = {"x-api-key": Config.API_KEY}
    files = {"file": (filename, file_content, "application/pdf")}
    response = requests.post(upload_url, headers=headers, files=files)
    response.raise_for_status()
    data = response.json()
    if not data["error"]:
        return data["url"]
    raise Exception(f"PDF.co upload failed: {data['message']}")

def extract_text_from_pdf(pdf_url, language="eng"):
    """Convert PDF to text with specified language."""
    convert_url = "https://api.pdf.co/v1/pdf/convert/to/text"
    headers = {"x-api-key": Config.API_KEY}
    # Map common languages to PDF.co OCR languages
    language_map = {
        "en": "eng",  # English
        "hi": "hin",  # Hindi
        "bn": "ben",  # Bengali
        # Add more as needed: https://apidocs.pdf.co/ocr-languages
    }
    ocr_language = language_map.get(language, "eng")  # Default to English
    data = {
        "url": pdf_url,
        "ocrLanguage": ocr_language,
        "inline": True  # Return text directly
    }

    response = requests.post(convert_url, headers=headers, data=data)
    response.raise_for_status()
    result = response.json()
    if result.get("error"):
        raise Exception("Text extraction failed")
    return result["body"]  # Direct text instead of URL