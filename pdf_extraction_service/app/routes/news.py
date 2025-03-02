import logging
from flask import Blueprint, request, jsonify
from ..services.pdfco_service import upload_file_to_pdfco, extract_text_from_pdf
from ..services.parser_service import parse_news_content

news_bp = Blueprint('news', __name__)

@news_bp.route('/extract_news', methods=['POST'])
def extract_news():
    logging.debug(f"Request headers: {request.headers}")

    # Check if 'file' is in the request
    if 'file' not in request.files:
        return jsonify({"error": "No file provided"}), 400

    uploaded_file = request.files['file']  # Get file from form-data

    if uploaded_file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    try:
        # Read file content
        file_content = uploaded_file.read()

        # Upload file to PDF.co
        pdf_url = upload_file_to_pdfco(file_content, uploaded_file.filename)
        extracted_text = extract_text_from_pdf(pdf_url)

        # Parse the extracted text
        structured_content = parse_news_content(extracted_text)

        return jsonify({
            "news_content": structured_content,
            "pdfco_response": {"status": "success"}
        })

    except Exception as e:
        logging.error(f"Error processing file: {str(e)}")
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500
