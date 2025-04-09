from flask import Flask, request, jsonify
import requests
import re

app = Flask(__name__)

# Your PDF.co API Key
API_KEY = "debdarudasgupta@outlook.com_HTA6h79lnMjBouWIs9AOX7emVeeQaaAVa1Uy29s3Ej616orkbmG4SpiwGAn6Ep00"

def upload_file_to_pdfco(file_content, filename):
    """Uploads a file to PDF.co and returns the URL of the uploaded file."""
    upload_url = "https://api.pdf.co/v1/file/upload"
    headers = {"x-api-key": API_KEY}
    files = {"file": (filename, file_content, "application/pdf")}

    response = requests.post(upload_url, headers=headers, files=files)
    response.raise_for_status()

    data = response.json()
    if not data["error"]:
        return data["url"]  # Uploaded file URL
    else:
        raise Exception(f"PDF.co upload failed: {data['message']}")

def parse_news_content(text):
    """Parse the extracted text into a structured format."""
    pages = []
    current_page = {"page_number": None, "sections": {}}
    section_title = None
    author = None
    body = []

    # Split text by page markers (e.g., "THE ASSAM TRIBUNE, GUWAHATI" followed by date)
    page_pattern = re.compile(r"THE ASSAM TRIBUNE, GUWAHATI\s+SUNDAY, MARCH 2, 2025", re.IGNORECASE)
    pages_raw = page_pattern.split(text)[1:]  # Skip initial metadata before first page

    for i, page_content in enumerate(pages_raw, start=1):
        current_page = {"page_number": i, "sections": {}}
        lines = page_content.splitlines()

        for line in lines:
            line = line.strip()

            # Identify section titles (e.g., NATIONAL, FICTION, etc.)
            section_match = re.match(r"^\s*([A-Z\s]+)$", line)
            if section_match and line.isupper() and len(line.split()) <= 3:
                if section_title and body:  # Save previous section
                    current_page["sections"][section_title] = {
                        "articles": [{"title": section_title, "author": author, "body": "\n".join(body)}]
                    }
                section_title = section_match.group(1).strip()
                author = None
                body = []
                continue

            # Identify author (e.g., "Dhruba Hazarika" or similar)
            author_match = re.match(r"^\s*([A-Za-z\s]+)$", line)
            if section_title and not author and author_match and len(line.split()) <= 3 and not line.isupper():
                author = author_match.group(1).strip()
                continue

            # Collect body content
            if section_title and line:
                body.append(line)

        # Save the last section of the page
        if section_title and body:
            current_page["sections"][section_title] = {
                "articles": [{"title": section_title, "author": author, "body": "\n".join(body)}]
            }

        pages.append(current_page)

    return pages

@app.route('/extract_news', methods=['POST'])
def extract_news():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    try:
        # 1️⃣ Upload file to PDF.co
        pdf_url = upload_file_to_pdfco(file.read(), file.filename)

        # 2️⃣ Convert PDF to Text
        convert_url = "https://api.pdf.co/v1/pdf/convert/to/text?ocr=true&ocrLanguage=eng"
        convert_headers = {"x-api-key": API_KEY}
        convert_data = {"url": pdf_url}

        response = requests.post(convert_url, headers=convert_headers, data=convert_data)
        response.raise_for_status()

        data = response.json()

        if data.get("error"):
            return jsonify({"error": "Text extraction failed", "pdfco_response": data}), 500

        # 3️⃣ Fetch Extracted Text from File URL
        text_url = data["url"]
        text_response = requests.get(text_url)
        extracted_text = text_response.text

        # 4️⃣ Parse the text into structured news content
        structured_content = parse_news_content(extracted_text)

        return jsonify({
            "news_content": structured_content,
            "pdfco_response": data
        })

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(debug=True)