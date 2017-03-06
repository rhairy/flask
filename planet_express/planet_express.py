import sqlite3
from flask import Flask, render_template
app = Flask(__name__)

@app.route('/') # Determines what URL triggers the app.
def index():
    return render_template('index.html')

@app.route('/hello/')
@app.route('/hello/<username>')
def hello(username = None):
    return render_template('hello.html', name = username)
