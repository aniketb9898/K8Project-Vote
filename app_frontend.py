from flask import Flask, request, render_template
import requests
import os

app = Flask(__name__)

@app.route('/vote/<username>', methods=['GET', 'POST'])
def vote(username):
    if request.method == 'POST':
        vote = request.form['vote']
        requests.post('http://backend:5001/vote', json={'vote': vote, 'user': username})
        return f"Thanks {username}, you voted for {vote}"
    return render_template('vote.html', user=username)

