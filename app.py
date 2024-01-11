'''
START Imports #################################################################################
'''
# Built-in Imports:
import os 
from functools import partial

# Third-party Imports:
from flask import Flask, render_template, request, url_for, redirect, session, Response, json
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

num_symptoms_selected = 1

'''
END App Configuration #########################################################################
'''


'''
START App Routes ##############################################################################
'''
@app.route("/")
def entry():
    return render_template("enterSymptoms.html", select_elements=num_symptoms_selected)

@app.route("/showCancers", methods=['POST', 'GET'])
def showCancers():
    if request.method == 'POST':
        data_dict = json.loads(request.data.decode())
        print(data_dict["patientSymptoms"])
        # Query DB to get diseases associated with symptoms
        diseases = [1, 2, 3]
        medDepartment = "Oncology"
        symptoms = data_dict["patientSymptoms"]
        return json.dumps({'data': render_template (
            "showCancers.html",
            diseases=diseases,
            medDepartment=medDepartment,
            symptoms=symptoms
        )}), 200, {'ContentType':'application/json'}
    
    return render_template (
        "showCancers.html"
    )

'''
END App Routes ################################################################################
'''


'''
START Socket Ons ##############################################################################
'''
@socketio.on("incrementSelectElementCount")
def incrementSelectElementCount():
    global num_symptoms_selected
    num_symptoms_selected += 1


@socketio.on("decrementSelectElementCount")
def decrementSelectElementCount():
    global num_symptoms_selected
    if num_symptoms_selected > 1:
        num_symptoms_selected -= 1

'''
END Socket Ons ################################################################################
'''
# GET from https://randomuser.me/api - random doctor data

# Run the app with SocketIO
if __name__ == "__main__":
    socketio.run(app, host=HOST, port=PORT, debug=True)