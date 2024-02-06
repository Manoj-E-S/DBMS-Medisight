# Built-in Imports
import os
import sys

# Third-party Imports:
from sqlalchemy import Integer, String, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column

# Custom Imports
rootdir = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
sys.path.append(rootdir)
from app_dependencies import app_setup


db = app_setup.db

class Departments(db.Model):
    __tablename__ = "departments"

    department_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    department_name: Mapped[str] = mapped_column(String, nullable=False)

    def __repr__(self):
        return f'<Department {self.department_name}>'


class Doctors(db.Model):
    __tablename__ = "doctors"

    doctor_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    doctor_name: Mapped[str]  = mapped_column(String, nullable=False)
    doctor_phno: Mapped[str]  = mapped_column(String)
    doctor_office_no: Mapped[str]  = mapped_column(String)
    doctor_office_address: Mapped[str]  = mapped_column(String)
    department_id: Mapped[int] = mapped_column(ForeignKey(Departments.department_id), nullable=False)

    def __repr__(self):
        return f'<Doctor {self.doctor_name} from Department-{self.department_id}>'


class Tests(db.Model):
    __tablename__ = "tests"

    test_id: Mapped[int] = mapped_column(Integer, nullable=False, primary_key=True)
    test_name: Mapped[str] = mapped_column(String, nullable=False)
    test_desc: Mapped[str] = mapped_column(String)

    def __repr__(self):
        return f'<Test {self.test_name} - {self.test_desc}>'


class Symptoms(db.Model):
    __tablename__ = "symptoms"

    symptom_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    symptom_name: Mapped[str] = mapped_column(String, nullable=False)

    def __repr__(self):
        return f'<Symptom {self.symptom_name}>'
    

class Diseases(db.Model):
    __tablename__ = "diseases"

    disease_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    disease_name: Mapped[str] = mapped_column(String, nullable=False)
    disease_desc: Mapped[str] = mapped_column(String)
    department_id: Mapped[int] = mapped_column(ForeignKey(Departments.department_id), nullable=False)

    def __repr__(self):
        return f'<Disease {self.disease_name} - {self.disease_desc}>'
    

class DiseaseSymptoms(db.Model):
    __tablename__ = "diseaseSymptoms"

    disease_id: Mapped[int] = mapped_column(ForeignKey(Diseases.disease_id), primary_key=True, nullable=False)
    symptom_id: Mapped[int] = mapped_column(ForeignKey(Symptoms.symptom_id), primary_key=True, nullable=False)

    def __repr__(self):
        return f'<DiseaseSymptom: D({self.disease_id}) - S({self.symptom_id})>'
    

class DiseaseTests(db.Model):
    __tablename__ = "diseaseTests"

    disease_id: Mapped[int] = mapped_column(ForeignKey(Diseases.disease_id), primary_key=True, nullable=False)
    test_id: Mapped[int] = mapped_column(ForeignKey(Tests.test_id), primary_key=True, nullable=False)

    def __repr__(self):
        return f'<DiseaseTest: D({self.disease_id}) - T({self.test_id})>'
