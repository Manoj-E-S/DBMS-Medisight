'''
START Imports #################################################################################
'''
# Built-in Imports:
import os 
from functools import partial

# Third-party Imports:
from flask import render_template, json, jsonify, request, url_for, redirect, session, Response

# Custom Imports:
from app_dependencies import app_setup
from db_dependencies.models import Departments, Doctors, Tests, Symptoms, Diseases, DiseaseSymptoms

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
        symptoms = data_dict["patientSymptoms"]

        try:
            query_result = (
                db.session.query(Diseases, Departments.department_name, Symptoms)
                .join(Departments, Diseases.department_id == Departments.department_id)
                .join(DiseaseSymptoms, Diseases.disease_id == DiseaseSymptoms.disease_id)
                .join(Symptoms, DiseaseSymptoms.symptom_id == Symptoms.symptom_id)
                .filter(Symptoms.symptom_id.in_(symptoms))
                .all()
            )

            # Organise Result Dict
            result = {}
            for disease, department_name, symptom in query_result:
                if disease.disease_name not in result:
                    result[disease.disease_name] = {
                        'disease_desc': disease.disease_desc,
                        'department_name': department_name,
                        'symptoms': []
                    }

                result[disease.disease_name]['symptoms'].append(symptom.symptom_name)

            return jsonify(result)

        except Exception as e:
            return jsonify({'error': str(e)})
    

    data_dict = json.loads(request.args["data"][:-1])
    return render_template (
        "showCancers.html",
        data_dict=data_dict
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