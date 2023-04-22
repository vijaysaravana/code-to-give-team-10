from web.models.User import User
import logging
logger = logging.getLogger(__name__)

def get_user_by_dict(user_dict):
    user = None
    if user_dict:
        user = User(**user_dict)
    return user


class UserDAO:

    def __init__(self, dao):
        self.dao = dao
        self.table = "users"

    def get_all_users(self):
        users = self.dao.get_all("SELECT * FROM {}".format(self.table))
        all_users = []
        if users:
            for user_dict in users:
                all_users.append(get_user_by_dict(user_dict))
        return all_users
    
    def get_all(self, query):
        users = self.dao.get_all(query)
        all_users = []
        if users:
            for user_dict in users:
                all_users.append(get_user_by_dict(user_dict))
        return all_users

    def get_user(self, email, password):
        query = "SELECT * FROM {} WHERE email = '{}' AND password = '{}'".format(self.table, email, password)
        return self.get_user_by_query(query)

    def get_user_by_query(self, query):
        user_dict = self.dao.get(query)
        return get_user_by_dict(user_dict)

    def get_user_by_email(self, email):
        query = "SELECT * FROM {} WHERE email = '{}'".format(self.table, email)
        return self.get_user_by_query(query)

    def create_user(self, user):
        admin = 1 if user.admin else 0
        query = "INSERT INTO {} (`first_name`, `last_name`, `email`, `password`, `admin`) " \
                "VALUES ('{}', '{}', '{}', '{}', '{}')".format(self.table, user.first_name, user.last_name, user.email,
                                                               user.password, admin)
        user = self.dao.insert(query)
        return user
    
    def get_users_by_city(self, city, role=None):
        if role is None:
            query = "SELECT * FROM {} WHERE city = '{}'".format(self.table, city)
            return self.get_all(query)
        else:
            if role == 'maker':
                return self.get_wish_makers_by_city(city)
            elif role == 'giver':
                return self.get_wish_givers_by_city(city)
            elif role == 'volunteer':
                return self.get_volunteers_by_city(city)
            elif role == 'staff':
                return self.get_staff_by_city(city)
        return None
    
    def get_users_by_role(self, role=None):
        if role == 'maker':
            return self.get_wish_makers()
        elif role == 'giver':
            return self.get_wish_givers()
        elif role == 'volunteer':
            return self.get_volunteers()
        elif role == 'staff':
            return self.get_staff()
        return None
    
    def get_wish_makers_by_city(self, city):
        query = "SELECT * FROM {} WHERE city = '{}' AND role = 'maker'".format(self.table, city)
        return self.get_all(query)

    def get_wish_givers_by_city(self, city):
        query = "SELECT * FROM {} WHERE city = '{}' AND role = 'giver'".format(self.table, city)
        return self.get_all(query)
    
    def get_volunteers_by_city(self, city):
        query = "SELECT * FROM {} WHERE city = '{}' AND role = 'volunteer'".format(self.table, city)
        return self.get_all(query)
    
    def get_staff_by_city(self, city):
        query = "SELECT * FROM {} WHERE city = '{}' AND role = 'staff'".format(self.table, city)
        return self.get_all(query)
    
    def get_wish_makers(self):
        query = "SELECT * FROM {} WHERE role = 'maker'".format(self.table)
        return self.get_all(query)
    
    def get_wish_givers(self):
        query = "SELECT * FROM {} WHERE role = 'giver'".format(self.table)
        return self.get_all(query)
    
    def get_volunteers(self):
        query = "SELECT * FROM {} WHERE role = 'volunteer'".format(self.table)
        return self.get_all(query)
    
    def get_staff(self):
        query = "SELECT * FROM {} WHERE role = 'staff'".format(self.table)
        return self.get_all(query)