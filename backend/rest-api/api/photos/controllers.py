from flask import request
from flask_restful import Resource, abort, url_for
from marshmallow import ValidationError
from sqlalchemy.sql import func
from api.photos.parsers import CoordinateSchema
from api.utils import make_response, make_empty
from sqlalchemy import exc
from datetime import datetime


# todo: Add Resource
class Photo(Resource):
    @staticmethod
    # def get():
    #     """Получить список маршрутов"""

    #     return make_response(200, {"name":"local"})

    @staticmethod
    def post():
        """Провериь новое фото"""

        
