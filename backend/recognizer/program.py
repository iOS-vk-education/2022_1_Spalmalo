from PIL import Image

from tkinter import Tk
from tkinter import ttk
from tkinter import filedialog

import numpy as np
import tensorflow as tf

interface = Tk()
model = tf.keras.models.load_model("model")

IMAGE_SIZE = (28, 28)

def preprocess_image(img):
    image = Image.fromarray(img)
    image = image.resize(IMAGE_SIZE)
    image = image.convert('L')
    
    return np.asarray(image)

def recognize_image():
    image_path = filedialog.askopenfilename()
    print("IMG PATH", image_path)
    image = preprocess_image(np.asarray(Image.open(image_path)))
    print("Array = ", np.asarray(Image.open(image_path)))
    result = model.predict(image[np.newaxis])
    print("RESULT: = ", result)
    print("MAX RESULT = ", np.max(result))
    
    cls = ["FAKE", "REAL"][np.argmax(result)]
    score = np.max(result)

    label.config(text=f"{cls}, {score}")

button = ttk.Button(interface, text="Проверить фотографию", command=recognize_image)  # <------
button.grid(column=1, row=1)

label = ttk.Label(text="---------")
label.grid(column=1, row=2)

interface.mainloop()