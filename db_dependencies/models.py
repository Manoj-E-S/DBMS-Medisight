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

class Department(db.Model):
    department_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    department_name: Mapped[str] = mapped_column(String, nullable=False)

    def __repr__(self):
        return f'<Department {self.department_name}>'


class Doctor(db.Model):
    doctor_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    doctor_name: Mapped[str]  = mapped_column(String, nullable=False)
    doctor_phno: Mapped[str]  = mapped_column(String)
    doctor_office_no: Mapped[str]  = mapped_column(String)
    doctor_office_address: Mapped[str]  = mapped_column(String)
    department_id: Mapped[int] = mapped_column(ForeignKey(Department.department_id), nullable=False)

    def __repr__(self):
        return f'<Doctor {self.doctor_name} from Department-{self.department_id}>'


class Test(db.Model):
    test_id: Mapped[int] = mapped_column(Integer, nullable=False, primary_key=True)
    test_name: Mapped[str] = mapped_column(String, nullable=False)
    test_desc: Mapped[str] = mapped_column(String)

    def __repr__(self):
        return f'<Test {self.test_name}\n\t- {self.test_desc}>'


class Symptom(db.Model):
    symptom_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    symptom_name: Mapped[str] = mapped_column(String, nullable=False)
    test_id: Mapped[int] = mapped_column(ForeignKey(Test.test_id), nullable=False)

    def __repr__(self):
        return f'<Symptom {self.symptom_name}>'
    

class Disease(db.Model):
    disease_id: Mapped[int] = mapped_column(Integer, primary_key=True, nullable=False)
    disease_name: Mapped[str] = mapped_column(String, nullable=False)
    disease_desc: Mapped[str] = mapped_column(String)
    department_id: Mapped[int] = mapped_column(ForeignKey(Department.department_id), nullable=False)
    symptom_id: Mapped[int] = mapped_column(ForeignKey(Symptom.symptom_id), nullable=False)

    def __repr__(self):
        return f'<Disease {self.disease_name}:\n\t- {self.disease_desc}>'
