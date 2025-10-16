from flask import Flask
import os
import pyodbc

app = Flask(__name__)

@app.route("/")
def home():
    db_host = os.getenv("DATABASE_HOST", "Not Set")
    db_name = os.getenv("DATABASE_NAME", "Not Set")
    db_user = os.getenv("DATABASE_USER", "Not Set")

    return f"""
    <h1>✅ Deployed via GitHub Actions</h1>
    <p><b>App:</b> Flask demo running on Azure Web App</p>
    <p><b>DB Host:</b> {db_host}</p>
    <p><b>DB Name:</b> {db_name}</p>
    <p><b>DB User:</b> {db_user}</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
