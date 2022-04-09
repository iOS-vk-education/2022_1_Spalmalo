from flask_cors import CORS
from flask_marshmallow import Marshmallow

cors = CORS(resource={r"/api/v1/*": {"origins": "*"}})
ma = Marshmallow()
