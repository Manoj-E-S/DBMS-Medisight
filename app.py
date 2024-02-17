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
from db_dependencies.models import Departments, DiseaseTests, Doctors, Tests, Symptoms, Diseases, DiseaseSymptoms

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


@app.route("/registerDoctor", methods=['POST', 'GET'])
def registerDoctor():
    if request.method == 'POST':
        data_dict = json.loads(request.data.decode())

        """
        insert into doctors
        (doctor_name, doctor_phno, doctor_office_no, doctor_office_address, department_id)
        values
        (user input values from the form);
        """
        
        doctor = Doctors(
            doctor_name=data_dict["doctorName"], 
            doctor_phno=data_dict["doctorPhno"], 
            doctor_office_no=data_dict["doctorOfficeNo"], 
            doctor_office_address=data_dict["doctorOfficeAddress"], 
            department_id=data_dict["departmentId"]
        )
        db.session.add(doctor)
        db.session.commit()
        return jsonify({"status":"Doctor Registered Successfully"})
    
    return render_template("registerDoctor.html")


@app.route("/showCancers", methods=['POST', 'GET'])
def showCancers():

    if request.method == 'POST':
        data_dict = json.loads(request.data.decode())
        symptoms = data_dict["patientSymptoms"]

        try:
            """
            select diseases.*, departments.department_name, symptoms.*
            from diseases
            join departments on diseases.department_id = departments.department_id
            join diseaseSymptoms on diseases.disease_id = diseaseSymptoms.disease_id
            join symptoms on diseaseSymptoms.symptom_id = symptoms.symptom_id
            where symptoms.symptom_id in (LIST of user selected symptom_ids);
            """

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
            print(f"Exception Occured:\n{e}")
            return jsonify({'error': str(e)})
    

    data_dict = json.loads(request.args["data"][:-1])
    return render_template (
        "showCancers.html",
        data_dict=data_dict
    )


@app.route("/showTests/<string:disease_name>")
def showTests(disease_name):
    try:
        """
        select tests.*, departments.department_name
        from tests
        join diseaseTests on tests.test_id = diseaseTests.test_id
        join diseases on diseaseTests.disease_id = diseases.disease_id
        join departments on diseases.department_id = departments.department_id
        where diseases.disease_name = (User input disease name);
        """

        query_result = (
            db.session.query(Tests, Departments.department_name)
            .join(DiseaseTests, Tests.test_id == DiseaseTests.test_id)
            .join(Diseases, DiseaseTests.disease_id == Diseases.disease_id)
            .join(Departments, Diseases.department_id == Departments.department_id)
            .filter(Diseases.disease_name == disease_name)
            .all()
        )

        # Organise Result Dict
        result = {}
        for test, department_name in query_result:
            if test.test_name not in result:
                result[test.test_name] = {
                    'test_desc': test.test_desc,
                    'department_name': department_name
                }

        return render_template("showTests.html", data_dict=result)

    except Exception as e:
        print(f"Exception Occured:\n{e}")
        return jsonify({'error': str(e)})


@app.route("/showDoctors/<string:department_name>")
def showDoctors(department_name):
    try:
        """
        select doctors.*, departments.department_name
        from doctors
        join departments on doctors.department_id = departments.department_id
        where departments.department_name = (User input department name);
        """

        query_result = (
            db.session.query(Doctors, Departments.department_name)
            .join(Departments, Doctors.department_id == Departments.department_id)
            .filter(Departments.department_name == department_name)
            .all()
        )

        print(query_result)

        # Organise Result Dict
        result = {}
        for doctor, department_name in query_result:
            if doctor.doctor_name not in result:
                result[doctor.doctor_name] = {
                    'doctor_phno': doctor.doctor_phno,
                    'doctor_office_no': doctor.doctor_office_no,
                    'doctor_office_address': doctor.doctor_office_address,
                    'department_name': department_name
                }

        print(result)

        return render_template("showDoctors.html", data_dict=result)

    except Exception as e:
        print(f"Exception Occured:\n{e}")
        return jsonify({'error': str(e)})

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