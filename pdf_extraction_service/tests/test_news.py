import pytest
from app import create_app

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_extract_news_no_file(client):
    response = client.post('/api/extract_news')
    assert response.status_code == 400
    assert b"No file part" in response.data