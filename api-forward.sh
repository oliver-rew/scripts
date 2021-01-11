#!/usr/bin/python3

import os
import io
import requests
from flask import Flask, request, abort, jsonify, send_from_directory, Response

api = Flask(__name__)

@api.route("/")
def get_image():

    resp = requests.get('http://192.168.7.2:5000/image.jpeg?coarse_time=1000')

    return Response(resp.content, mimetype='text/plain')

if __name__ == "__main__":
    api.run(host='0.0.0.0', debug=True, port=5000)
