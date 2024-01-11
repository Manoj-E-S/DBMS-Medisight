'''
START Imports #################################################################################
'''
# Built-in Imports:
import os 
from functools import partial

# Third-party Imports:
from flask import render_template, json, request, url_for, redirect, session, Response

# Custom Imports:
from app_dependencies import app_setup
from db_dependencies import models

'''
END Imports ###################################################################################
'''


'''
START App Configuration (Flask, Flask-Assets, etc.) ########################################### 
'''
app = app_setup.app
socketio = app_setup.socketio
db = app_setup.db

HOST = app_setup.getHost()
PORT = app_setup.getPort()

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

        template_dict = {
            'data': render_template (
                "showCancers.html",
                diseases=diseases,
                medDepartment=medDepartment,
                symptoms=symptoms
            )
        }
        return json.dumps(template_dict), 200, {'ContentType':'application/json'}
    
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