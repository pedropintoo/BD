import sys
sys.path.append('.')
 
import pyodbc
import json
import urllib
import gzip
from persistency.session import create_connection
from tables import *
from full_data.download import get_fullData_links

def getNextInstitutionID():
    with create_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(InstitutionID) FROM Institution")
        result = cursor.fetchone()
        return int(result[0]) + 1 if result[0] else 1


def insert_author(author: Author):
    with create_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute(
                "INSERT INTO Author VALUES (?, ?, ?, ?, ?)",
                author.AuthorID,
                author.Name,
                author.Email,
                author.ORCID,
                author.InstitutionID)
            cursor.commit()
        except pyodbc.IntegrityError as e:
            print("Author integrity error.", e)
        except pyodbc.ProgrammingError as e:
            print("Author creation error.", e) 
        except pyodbc.DataError as e:
            print("Truncated maybe. Error...", author, e)  
        except Exception as e:
            print("Error...", author, e)

def insert_institution(institution: Institution):
    with create_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute(
                "INSERT INTO Institution VALUES (?, ?, ?)",
                institution.InstitutionID,
                institution.Name,
                institution.Address)
            cursor.commit()
        except pyodbc.IntegrityError as e:
            print("Institution integrity error.", e)
        except pyodbc.ProgrammingError as e:
            print("Institution creation error.", e)
        except pyodbc.DataError as e:
            print("Truncated maybe. Error...", Institution, e) 
        except Exception as e:
            print("Error...", Institution, e)   
             

def insert_authors_and_institutions(buffer):
    # Read data from the file into a list of dictionaries
    for line in buffer:
        # Load each line as JSON
        author_data = json.loads(line)
        institution_name = author_data['affiliations'][0] if author_data["affiliations"] else None

        if institution_name:
            # Create Institution object
            institution = Institution(
                InstitutionID = getNextInstitutionID(),
                Name = institution_name,
                Address = None
                )

            # Insert institution data
            insert_institution(institution)


        # Create Author object
        author = Author(
            AuthorID = author_data["authorid"],
            Name = author_data["name"],
            Email = None,
            ORCID = author_data["externalids"].get("ORCID", None) if author_data["externalids"] else None,
            InstitutionID = institution.InstitutionID if institution_name else None
            )

        # Insert author data
        insert_author(author)

def insert_topic(topic: Topic):
    with create_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute(
                "INSERT INTO Topic VALUES (?, ?, ?)",
                topic.TopicID,
                topic.Name,
                topic.Description)
            cursor.commit()
        except pyodbc.IntegrityError as e:
            print("Topic integrity error.", e)
        except pyodbc.ProgrammingError as e:
            print("Topic creation error.", e)
        except pyodbc.DataError as e:
            print("Truncated maybe. Error...", topic, e) 
        except Exception as e:
            print("Error...", topic, e)



if __name__ == '__main__':
    # # Authors + Institutions
    # file_path = "tables\\sample-data\\authors\\authors_sample.jsonl"
    # buffer = open(file_path, "r", encoding="utf-8").readlines()
    # insert_authors_and_institutions(buffer)

    buffer = gzip.open("tables\\full_data\\author0.jsonl.gz", "r").readlines()
    print("buffer length: ", len(buffer))
    for i in range(0, len(buffer), 100):
        insert_authors_and_institutions(buffer[i:i+100])
        print("inserted [", i, ":", i+100, "].")

    # buffer = open(file_path, "r", encoding="utf-8").readlines()
    # insert_authors_and_institutions(buffer)