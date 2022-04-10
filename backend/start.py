from app import create_app
from os import getenv


app = create_app()

app.run(host="0.0.0.0", port=8080)
