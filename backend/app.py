from flask import Flask


app = Flask(__name__)

# Register extensions
from extensions import cors, ma
cors.init_app(app)
ma.init_app(app)

# Register Blueprints
from api.photos import api_tracks_bp
app.register_blueprint(api_tracks_bp, url_prefix="/api/v1")


if __name__ == '__main__':
    app.run()

