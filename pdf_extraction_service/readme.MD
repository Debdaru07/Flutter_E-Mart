# News Extraction Service

A Flask-based service to extract and parse news content from PDF files using PDF.co API.

## Setup
1. Install dependencies: `pip install -r requirements.txt`
2. Run the app: `python run.py`

## Usage
- POST `/api/extract_news` with a PDF file to extract news content.

## Structure
- `app/`: Core application files
- `routes/`: API endpoints
- `services/`: Business logic
- `utils/`: Helper functions
- `tests/`: Unit tests
- `run.py`: Entry point