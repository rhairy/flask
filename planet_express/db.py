import os.path
import sqlite3

""" Open the database and check that the schema is correct. """
def dbOpen(db):
    r = sqlite3.connect(db)
    c = r.cursor()
    c.execute("SELECT * FROM Employee;")
    c.close()
    return r

""" Close the database. """
def dbClose(db):
    db.close()

""" Get a list of Planet Express employees. """
def getEmployees(db):
    c = db.cursor()
    c.execute("SELECT Name, Position, Salary FROM Employee;")
    l = []
    for row in c:
        l.append(row) 
    c.close()
    return l

database = "planet_express.db"

try:
    r = dbOpen(database)
    l = getEmployees(r)
    print(l)
    dbClose(r)
except Exception as e:
    print("Unhandled Exception: %s" % e)

