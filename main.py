import re
import json
import random
from db__functions import *
from flask import Flask, render_template, request, redirect, url_for, session


app = Flask(__name__)

appName         = "APPIyhhh"

# Each Flask web application contains a secret key which used to sign session cookies for protection against cookie data tampering
app.secret_key  = "1a2b3c4d5e"


def CheckUserSessionChallenge(table_name):
    if table_name not in session:
        session[table_name] = json.dumps({})

    return json.loads(session[table_name])


def AppendDataUserSessionChallenge(table_name, keys, values):
    UserProgress = json.loads(session[table_name])
    NewUserProgress = UserProgress
    NewUserProgress[keys] = values
    session[table_name] = json.dumps(NewUserProgress)

    if json.loads(session[table_name])[str(keys)] == values:
        return True
    else:
        return False


@app.route("/")
def home():
    cursor = mysql.cursor()
    cursor.execute("SELECT * FROM tb_datasoal")
    result = cursor.fetchall()

    return render_template(
        "home/home.html", title="Home", appname=appName, backend_data=result
    )


@app.route("/profile")
def profile():
    if "loggedin" in session:
        cursor = mysql.cursor()
        cursor.execute("SELECT * FROM tb_datasoal")
        result = cursor.fetchall()
        return render_template(
            "home/profile.html", title="Profile", appname=appName, datasoal=result, username=session["username"]
        )
    return render_template("auth/login.html", title="Login")


@app.route("/login", methods=["GET", "POST"])
def login():
    if "loggedin" in session:
        return redirect(url_for("home"))
    else:
        if (
            request.method == "POST"
            and "username" in request.form
            and "password" in request.form
        ):
            username = request.form["username"]
            password = request.form["password"]
            cursor = mysql.cursor()
            cursor.execute(
                "SELECT * FROM accounts WHERE username = %s AND password = %s",
                (username, password),
            )
            account = cursor.fetchone()
            if account:
                session["loggedin"] = True
                session["id"] = account["id"]
                session["username"] = account["username"]
                return redirect(url_for("home"))
            else:
                msg = "Incorrect username/password!"

            return render_template("auth/login.html", title="Login", msg=msg)
        return render_template("auth/login.html", title="Login")


@app.route("/register", methods=["GET", "POST"])
def register():
    if "loggedin" in session:
        return redirect(url_for("home"))
    else:
        if (
            request.method == "POST"
            and "username" in request.form
            and "password" in request.form
            and "email" in request.form
        ):
            username = request.form["username"]
            password = request.form["password"]
            email = request.form["email"]

            cursor = mysql.cursor()
            cursor.execute("SELECT * FROM accounts WHERE username = %s", (username))
            account = cursor.fetchone()
            if account:
                msg = "Account already exists!"
            elif not re.match(r"[^@]+@[^@]+\.[^@]+", email):
                msg = "Invalid email address!"
            elif not re.match(r"[A-Za-z0-9]+", username):
                msg = "Username must contain only characters and numbers!"
            elif not username or not password or not email:
                msg = "Incorrect username/password!"
            else:
                cursor.execute(
                    "INSERT INTO accounts VALUES (NULL, %s, %s, %s)",
                    (username, email, password),
                )
                mysql.commit()
                return redirect(url_for("login"))

            return render_template("auth/register.html", title="Register", msg=msg)

        elif request.method == "POST":
            return render_template("auth/register.html", title="Register", msg="Please fill out the form!")
        return render_template("auth/register.html", title="Register")




@app.route("/quiz/<int:IdSoal>/<IdQuest>", methods=["GET", "POST"])
def test(IdSoal, IdQuest):
    # CHECK SESSION LOGIN = USER SUDAH LOGIN ATAU BELUM JIKA TIDAK REDIRECT KE LOGIN PAGE
    if "loggedin" in session:

        # GET DATA EXAM BY ID SOAL JIKA GET EXAM FALSE MAKA 404 NOT FOUND
        # JIKA GET EXAM NOT FALSE MAKA LANJUT PROSES
        GetExam = GetExamById(IdSoal)
        if GetExam != False:

            # GET USER ID DI SESSION
            UserIdInSession = session["id"]
            # COBA UNTUK SET DATA EXAM JIKA USER BELUM TERDAFTAR DIDATABASE MAKA SET DI "TABLE_NAMA_USERS"
            # DENGAN VALUE LIST SOAL ID YANG SUDAH DIACAK
            UserDataExam    = TrySetUserDataExam(
                GetExam["table_data"], UserIdInSession, GetExam["count_soal"]
            )

            # CHECK USER SUDAH MENGERJAKAN ATAU BELUM, JIKA SUDAH MAKA TAMPILKAN PEMBAHASAN SOAL
            if GetUserDataExamHasFinish(GetExam["table_data"], UserIdInSession) != None:
                fresh_show_to_user          = {}
                fresh_show_to_user_other    = {}
                UserDataExam                = GetUserDataExam(GetExam["table_data"], UserIdInSession)
                GetAllSoal                  = GetAllSoalByTable(GetExam["table_data"])
                SoalRight                   = 0

                
                UserAnswer      = json.loads(UserDataExam["user_answered"])
                UserAnswerMap   = json.loads(UserDataExam["answer"])


                fresh_show_to_user_other["title"] = GetExam["title"]

                for k in UserAnswerMap:
                    fresh_show_to_user[k] = {}
                    GetDataExam          = next((item for item in GetAllSoal if item["id"] == int(k)), None)

                    AnswerRight          = GetDataExam["answer_r"]
                    fresh_show_to_user[k]["questions_data"]    = GetDataExam["questions"]
                    fresh_show_to_user[k]["answer_right"]      = AnswerRight
                    fresh_show_to_user[k]["answer_right_text"] = GetDataExam[AnswerRight]
                    if k in UserAnswer.keys():
                        RealUserId            = UserAnswerMap[k]
                        RealUserAnswer        = UserAnswer[k]

                        fresh_show_to_user[k]["user_answer"]      = RealUserAnswer
                        fresh_show_to_user[k]["user_answer_text"] = GetDataExam[RealUserAnswer]
                        if RealUserAnswer == AnswerRight:
                            SoalRight += 1
                    else:
                        fresh_show_to_user[k]["user_answer"] = False

                    fresh_show_to_user_other["soal_all"]        = GetExam["count_soal"]
                    fresh_show_to_user_other["soal_right"]      = SoalRight
                    fresh_show_to_user_other["soal_not_right"]  = (int(GetExam["count_soal"]) - SoalRight)
                    fresh_show_to_user_other["soal_total"]      = round((100 / int(GetExam["count_soal"])) * SoalRight)

                    
                return render_template('home/quiz-end.html', username=session['username'], title="Quiz", backend_data=fresh_show_to_user, other=fresh_show_to_user_other)


                

            # CHECK SESSION QUIZ = JIKA SESSION BELUM ADA MAKA BUAT SESSION
            # DENGAN NAMA "TABLE_NAMA" DENGAN VALUE KOSONG UNTUK NANTINYA DIAPPEND DENGAN JAWABAN
            CheckUserSessionChallenge(GetExam["table_data"])
            if (
                request.method == "POST"
                and "user_answer"   in request.form
                and "soal_id"       in request.form
            ):
                # JIKA USER MELALKUKAN POST DATA MAKA APPEND KE SESSION YANG BERNAMA "TABLE_NAMA" DAN VALUE BERISI SOAL ID DAN USER ANSWER
                AppendDataUserSessionChallenge(
                    GetExam["table_data"],
                    request.form["soal_id"],
                    request.form["user_answer"],
                )
            
            # JIKA IdQuest BUKAN NUMERIC MAKA QUIZ SELESAI LALU SIMPAN SESSION KEDATABASE
            if IdQuest.isnumeric() == False:
                if GetUserDataExamHasFinish(GetExam["table_data"], UserIdInSession) == None:
                    SetUserDataExamHasFinish(
                        GetExam["table_data"],
                        UserIdInSession,
                        json.dumps(CheckUserSessionChallenge(GetExam["table_data"])),
                    )
                    return redirect(url_for("profile"))

                return "500 Internal Server Error"

            else:
                IdQuest = int(IdQuest)

            if UserDataExam != False:
                # JIKA CEK UserDataExam return False
                # MAKA SERVER MENGALAMI ERROR

                fresh_show_to_user = GetSoalByTableAndId(
                    GetExam["table_data"], IdQuest
                )

                if fresh_show_to_user != False:

                    # BUAT TEMPLATE RESPONSE BERBASIC DICT UNTUK DIRENDER KE HTML
                    return_to_render = {
                        "id": False,
                        "soal_id": IdSoal,
                        "fake_id": IdQuest,
                        "next_id": False,
                        "question": False,
                        "list_soal": list(range(1, (GetExam["count_soal"] + 1))),
                        "user_answer": CheckUserSessionChallenge(GetExam["table_data"]),
                        "soal_count": GetExam["count_soal"],
                        "choice": {},
                    }

                    return_to_render["id"]          = str(fresh_show_to_user["id"])
                    return_to_render["question"]    = fresh_show_to_user["questions"]
                    if (IdQuest + 1) > return_to_render["soal_count"]:
                        return_to_render["next_id"] = "endThis"
                    else:
                        return_to_render["next_id"] = IdQuest + 1
                    for key in fresh_show_to_user:
                        if "answer" in key and key != "answer_r":
                            return_to_render["choice"][key] = fresh_show_to_user[key]

                    randomized_answer = list(return_to_render["choice"].items())

                    random.shuffle(randomized_answer)
                    return_to_render["choice"] = dict(randomized_answer)

                    return render_template(
                        "home/quiz.html",
                        username=session["username"],
                        title="Quiz",
                        backend_data=return_to_render,
                    )

                else:
                    return "500 Internal Server Error"
            else:
                return "500 Internal Server Error"
        else:
            return "500 Internal Server Error"
    # User is not loggedin redirect to login page
    return redirect(url_for("login"))


@app.route("/logout")
def logout():
    if "loggedin" in session:
        session.clear()
    return redirect(url_for("login"))


if __name__ == "__main__":
    app.run()
