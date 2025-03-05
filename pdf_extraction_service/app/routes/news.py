import logging
import io
import re
from flask import Blueprint, request, jsonify
from ..services.text_extraction_service import extract_text_from_pdf
from ..services.image_extraction_service import extract_images_from_pdf

news_bp = Blueprint('news', __name__)

def clean_text(text):
    """Remove non-printable characters and normalize text for English and Indian regional languages."""
    if not isinstance(text, str):
        return ""
    
    # Unicode ranges for major Indian scripts
    indian_scripts = (
        r'\u0900-\u097F'  # Devanagari (Hindi, Marathi, etc.)
        r'\u0980-\u09FF'  # Bengali
        r'\u0A00-\u0A7F'  # Gurmukhi (Punjabi)
        r'\u0A80-\u0AFF'  # Gujarati
        r'\u0B00-\u0B7F'  # Oriya (Odia)
        r'\u0B80-\u0BFF'  # Tamil
        r'\u0C00-\u0C7F'  # Telugu
        r'\u0C80-\u0CFF'  # Kannada
        r'\u0D00-\u0D7F'  # Malayalam
        r'\u0D80-\u0DFF'  # Sinhala (sometimes relevant)
    )
    
    # Combine ranges with ASCII printable characters and common punctuation
    pattern = rf'[^\x20-\x7E{"".join(indian_scripts)}\n\t.,!?;:-।॥]'
    cleaned = re.sub(pattern, '', text)
    # Replace multiple spaces/newlines with single space
    cleaned = re.sub(r'\s+', ' ', cleaned)
    return cleaned.strip()

@news_bp.route('/extract_news', methods=['POST'])
def extract_news():
    """Extracts text and images from an uploaded PDF file and structures the output accordingly."""
    logging.debug(f"Request received with headers: {request.headers}")

    if 'file' not in request.files:
        return jsonify({"error": "No file provided"}), 400

    uploaded_file = request.files['file']
    if uploaded_file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    try:
        # Read file into memory
        file_data = io.BytesIO(uploaded_file.read())

        # Extract text
        extracted_text = extract_text_from_pdf(file_data)
        logging.debug(f"Extracted Text Type: {type(extracted_text)} | Content: {extracted_text}")

        # Normalize extracted_text into a consistent dictionary format
        if isinstance(extracted_text, str):
            extracted_text = {1: {"Default Section": {"author": "", "body": clean_text(extracted_text)}}}
        elif isinstance(extracted_text, list):
            extracted_text = {i+1: {"Default Section": {"author": "", "body": clean_text(text)}} for i, text in enumerate(extracted_text)}
        elif isinstance(extracted_text, dict):
            normalized_text = {}
            for page, content in extracted_text.items():
                if isinstance(content, str):
                    normalized_text[page] = {"Default Section": {"author": "", "body": clean_text(content)}}
                elif isinstance(content, dict):
                    normalized_text[page] = {k: {"author": v.get("author", ""), "body": clean_text(v.get("body", ""))} for k, v in content.items()}
                else:
                    logging.warning(f"Skipping page {page} due to unexpected content type: {type(content)}")
            extracted_text = normalized_text
        else:
            raise ValueError("Invalid text extraction format. Expected dict, list, or string.")
        logging.debug(f"Normalized Extracted Text: {extracted_text}")

        # Reset file pointer for image extraction
        file_data.seek(0)

        # Extract images
        extracted_images = extract_images_from_pdf(file_data)
        logging.debug(f"Raw Extracted Images Type: {type(extracted_images)} | Content: {extracted_images}")
        if not isinstance(extracted_images, dict):
            logging.warning(f"Converting extracted_images from {type(extracted_images)} to dict")
            extracted_images = {}
        logging.debug(f"Final Extracted Images: {extracted_images}")

        # Structuring the output
        structured_output = []

        for page_number, sections in extracted_text.items():
            if not isinstance(sections, dict):
                logging.warning(f"Skipping page {page_number} due to invalid section format: {sections}")
                continue

            page_data = {"page": page_number, "sections": []}
            page_images = extracted_images.get(page_number, [])
            logging.debug(f"Page {page_number} Images: {page_images}")

            for section_title, section_content in sections.items():
                if not isinstance(section_content, dict):
                    logging.warning(f"Skipping section {section_title} on page {page_number} due to invalid format: {section_content}")
                    continue

                # Use all page images if section-specific images aren't available
                section_images = page_images if page_images else []
                if isinstance(page_images, dict):  # If images are section-specific
                    section_images = page_images.get(section_title, [])
                if not isinstance(section_images, list):
                    logging.debug(f"Section {section_title} images are not a list: {section_images}, defaulting to empty list")
                    section_images = []

                section_data = {
                    "title": section_title,
                    "author": section_content.get("author", ""),
                    "body_content": section_content.get("body", ""),
                    "relevant_images": section_images  # List of image data (e.g., bytes or base64)
                }
                page_data["sections"].append(section_data)

            if page_data["sections"]:
                structured_output.append(page_data)

        logging.debug(f"Final Structured Output: {structured_output}")
        if not structured_output:
            return jsonify({"error": "No extractable content found in the PDF"}), 204

        return jsonify({"news_pages": structured_output}), 200

    except Exception as e:
        logging.error(f"Error processing file: {str(e)}")
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500