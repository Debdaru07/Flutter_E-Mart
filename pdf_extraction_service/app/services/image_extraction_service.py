import fitz  # PyMuPDF
import base64

def extract_images_from_pdf(file):
    """
    Extracts images from a PDF file and returns them as base64-encoded strings mapped to page numbers.
    """
    pdf_document = fitz.open(stream=file.read(), filetype="pdf")
    extracted_images = {}

    for page_number in range(len(pdf_document)):
        page = pdf_document[page_number]
        images = page.get_images(full=True)

        if images:
            extracted_images[page_number + 1] = []

            for img in images:
                xref = img[0]
                base_image = pdf_document.extract_image(xref)
                image_bytes = base_image["image"]
                
                # Convert to Base64 string (or save to disk if needed)
                base64_img = base64.b64encode(image_bytes).decode("utf-8")
                extracted_images[page_number + 1].append(f"data:image/png;base64,{base64_img}")

    pdf_document.close()
    return extracted_images
