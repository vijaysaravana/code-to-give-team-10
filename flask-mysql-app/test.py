import logging
from flask import Flask
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'flask_app_db'
app.config['MYSQL_PORT'] = 3306
app.config['DEBUG'] = 3306

mysql = MySQL(app)

@app.route('/')
def index():
    conn = mysql.connection
    if conn is None:
        logging.error('Connection to MySQL database failed')
    else:
        logging.info('Connection to MySQL database successful')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM users')
    data = cursor.fetchall()
    # cursor.close()
    # conn.close()
    return str(data)

if __name__ == '__main__':
    app.run(debug=True)
