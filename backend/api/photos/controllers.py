from flask import request
from flask_restful import Resource
from sqlalchemy.sql import func
from api.photos.parsers import CoordinateSchema
from api.utils import make_response, make_empty

from PIL import Image
import numpy as np
import tensorflow as tf
from pathlib import Path 

IMAGE_SIZE = (28, 28)

model = tf.keras.models.load_model(Path(Path.cwd(), "recognizer", "model"))

def preprocess_image(img):
    image = Image.fromarray(img)
    image = image.resize(IMAGE_SIZE)
    image = image.convert('L')

    return np.asarray(image)

class Photo(Resource):
    @staticmethod
    def post():
        """Провериь новое фото"""
        image = preprocess_image(np.asarray(Image.open("/Users/ztursunov/Desktop/deepfake/real/121560.jpg")))
        result = model.predict(image[np.newaxis])
    
        cls = ["FAKE", "REAL"][np.argmax(result)]
        score = np.max(result)
        return make_response(200, result = {"class": cls, 
                                            "score": str(score)})

        
