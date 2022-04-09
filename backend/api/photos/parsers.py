from marshmallow import Schema, fields
from datetime import datetime


class CoordinateSchema(Schema):
    datetime = fields.DateTime(attribute="datetime_at", format="iso8601",
                               required=True)
    lat = fields.Float(attribute="latitude", required=True)
    lon = fields.Float(attribute="longitude", required=True)
