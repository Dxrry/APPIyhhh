import json
import random
import pymysql


def connection():
    s = "localhost"
    d = "community_app"
    u = "chickennugget"
    p = "chickennuggetpassword"
    conn = pymysql.connect(
        host=s, user=u, password=p, database=d, cursorclass=pymysql.cursors.DictCursor
    )
    return conn



mysql = connection()


def GetUserDataExam(table_name, user_id):
    cursor = mysql.cursor()
    query = "SELECT * FROM {}_users WHERE user_id = {}".format(table_name, user_id)
    cursor.execute(query)
    cursor_fetch = cursor.fetchone()
    cursor.close()

    if cursor_fetch is not None and cursor_fetch["user_id"] == user_id:
        return cursor_fetch
    else:
        return False



def GetUserDataExamHasFinish(table_name, user_id):
    cursor = mysql.cursor()
    query = "SELECT * FROM {}_users WHERE user_id = {}".format(table_name, user_id)
    cursor.execute(query)
    cursor_fetch = cursor.fetchone()
    cursor.close()

    if cursor_fetch is not None and cursor_fetch["user_id"] == user_id:
        return cursor_fetch["user_answered"]



def SetUserDataExamHasFinish(table_name, user_id, json):
    cursor = mysql.cursor()
    query = "UPDATE {}_users SET user_answered = '{}' WHERE user_id = {}".format(
        table_name, json, user_id
    )
    cursor.execute(query)
    mysql.commit()
    cursor.close()



def TrySetUserDataExam(table_name, user_id, count_soal):
    ArraySoal = list(range(1, (count_soal + 1)))
    ShuffleArraySoal = sorted(ArraySoal, key=lambda k: random.random())
    DictSoal = json.dumps(dict(zip(ArraySoal, ShuffleArraySoal)))

    if GetUserDataExam(table_name, user_id) == False:
        cursor = mysql.cursor()
        query = "INSERT INTO {}_users VALUES (NULL, NULL, {}, '{}')".format(
            table_name, user_id, DictSoal
        )
        cursor.execute(query)
        mysql.commit()
        cursor.close()

    return GetUserDataExam(table_name, user_id)



def GetExamById(exam_id):
    cursor = mysql.cursor()
    query = "SELECT * FROM tb_datasoal WHERE id = {}".format(exam_id)
    cursor.execute(query)
    cursor_fetch = cursor.fetchone()
    cursor.close()

    if cursor_fetch is not None:
        return cursor_fetch
    else:
        return False



def GetSoalByTableAndId(table_name, soal_id):
    cursor = mysql.cursor()
    query = "SELECT * FROM {} WHERE id = {}".format(table_name, soal_id)
    cursor.execute(query)
    cursor_fetch = cursor.fetchone()
    cursor.close()

    if cursor_fetch is not None:
        return cursor_fetch
    else:
        return False



def GetAllSoalByTable(table_name):
    cursor = mysql.cursor()
    query = "SELECT * FROM {}".format(table_name)
    cursor.execute(query)
    cursor_fetch = cursor.fetchall()
    cursor.close()

    if cursor_fetch is not None:
        return cursor_fetch
    else:
        return False