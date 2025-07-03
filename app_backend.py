from flask import Flask, request
import redis
import os

app = Flask(__name__)
r = redis.StrictRedis(host='redis', port=6379, password=os.getenv('REDIS_PASSWORD'), decode_responses=True)

@app.route('/vote', methods=['POST'])
def vote():
    data = request.get_json()
    r.incr(data['vote'])
    return "Vote counted"

