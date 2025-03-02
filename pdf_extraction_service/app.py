from flask import Flask, request, jsonify
import requests
import os

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
    if data["error"] == False:
        return data["url"]  # Uploaded file URL
    else:
        raise Exception(f"PDF.co upload failed: {data['message']}")

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
        text_url = data["url"]  # Get text file URL
        text_response = requests.get(text_url)  # Fetch text from the URL
        extracted_text = text_response.text  # Read content

        return jsonify({
            "text": extracted_text,
            "pdfco_response": data
        })

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(debug=True)
