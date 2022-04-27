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

# На стороне клиента:
# 1) Открыть изображение и прогнать функцию preprocess_image(np.asarray(изображение))
# 2) Отправить полученный результат res.tolist() в виде запроса
def preprocess_image(img):
    image = Image.fromarray(img)
    image = image.resize(IMAGE_SIZE)
    image = image.convert('L')
    return np.asarray(image)

class Photo(Resource):
    @staticmethod
    def post():
        """Провериь новое фото"""
        image = request.files.get('data', '')
        decoded_image = preprocess_image(np.asarray(Image.open(image)))
       
        result = model.predict(decoded_image[np.newaxis])
    
        cls = ["FAKE", "REAL"][np.argmax(result)]
        score = np.max(result)
        return make_response(200, result = {"class": cls, 
                                            "score": str(score)})

        
