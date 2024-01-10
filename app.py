'''
START Imports #################################################################################
'''
# Built-in Imports:
import os 
from functools import partial

# Third-party Imports:
from flask import Flask, render_template, request, url_for, redirect, Response
from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy
import requests
from dotenv import load_dotenv

# Custom Imports:
# NONE
'''
END Imports ###################################################################################
'''


'''
START App Configuration (Flask, Flask-Assets, etc.) ########################################### 
'''
app = Flask('app', static_folder='static', template_folder='templates')
socketio = SocketIO(app)

HOST = os.environ.get("DEV_HOST")
PORT = os.environ.get("DEV_PORT")

num_symptom_select_html_elements = 1

'''
END App Configuration #########################################################################
'''


'''
START App Routes ##############################################################################
'''
@app.route("/")
def entry():
    return render_template("enterSymptoms.html", select_elements=num_symptom_select_html_elements)

@app.route("/showCancers", methods=['POST', 'GET'])
def showCancers():
    if request.method == 'POST':
        print(request.args)
        return Response(headers={'Content-Type': 'json'})
    else:
        return render_template("showCancers.html")

        # return render_template("")

'''
END App Routes ################################################################################
'''


'''
START Socket Ons ##############################################################################
'''
@socketio.on("incrementSelectElementCount")
def incrementSelectElementCount():
    global num_symptom_select_html_elements
    num_symptom_select_html_elements += 1


@socketio.on("decrementSelectElementCount")
def decrementSelectElementCount():
    global num_symptom_select_html_elements
    num_symptom_select_html_elements -= 1

'''
END Socket Ons ################################################################################
'''
# GET from https://randomuser.me/api - random doctor data

# Run the app with SocketIO
if __name__ == "__main__":
    socketio.run(app, host=HOST, port=PORT, debug=True)