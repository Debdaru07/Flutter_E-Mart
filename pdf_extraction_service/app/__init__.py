from flask import Flask
from .config import Config
from .routes.news import news_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Register blueprints
    app.register_blueprint(news_bp, url_prefix='/api')

    return app