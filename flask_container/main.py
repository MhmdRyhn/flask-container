from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():
    return '<h1>Hi, I am talking to the world from inside a Docker Container...!<h1>'
