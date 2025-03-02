from flask import Blueprint, request, jsonify
from ..services.pdfco_service import upload_file_to_pdfco, extract_text_from_pdf
from ..services.parser_service import parse_news_content

news_bp = Blueprint('news', __name__)

@news_bp.route('/extract_news', methods=['POST'])
def extract_news():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    try:
        # Upload and extract text
        pdf_url = upload_file_to_pdfco(file.read(), file.filename)
        extracted_text = extract_text_from_pdf(pdf_url)

        # Parse the extracted text
        structured_content = parse_news_content(extracted_text)

        return jsonify({
            "news_content": structured_content,
            "pdfco_response": {"status": "success"}  # Simplified for example
        })

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500