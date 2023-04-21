import MySQLdb
from flask_mysqldb import MySQL
import logging

class DbUtil:
    log = logging.getLogger(__name__)

    def __init__(self, app):
        app.logger.info("Initializing the MYSQL!!")
        self.mysql = MySQL(app)

    def cursor(self):
        logging.getLogger(__name__).info("Initializing cursor!!!")
        return self.mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    def query(self, query):
        cur = self.cursor()
        logging.getLogger(__name__).info("Runnign query cursor!!")
        cur.execute(query)
        return cur

    def commit(self):
        self.mysql.connection.commit()

    def rollback(self):
        self.mysql.connection.rollback()
