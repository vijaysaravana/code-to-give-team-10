from web.models.User import User
from web.models.Wish import Wish
from web.dao.UserDAO import UserDAO

import logging
logger = logging.getLogger(__name__)

def get_user_by_dict(user_dict):
    user = None
    if user_dict:
        user = User(**user_dict)
    return user

def get_wish_by_dict(wish_dict):
    wish = None
    if wish_dict:
        wish = Wish(**wish_dict)
    return wish

class WishDAO:

    def __init__(self, dao):
        self.dao = dao
        self.user_table = "users"
        self.wish_table = "wish"

    def get_all_wishes(self):
        wishes = self.dao.get_all("SELECT * FROM {}".format(self.wish_table))
        all_wishes = []
        logger.info("Wishes: {}".format(wishes))
        if wishes:
            for wish_dict in wishes:
                all_wishes.append(get_wish_by_dict(wish_dict))
        logger.info("All wishes: {}".format(all_wishes))
        return all_wishes
    
    def get_all(self, query):
        wishes = self.dao.get_all(query)
        logger.info("Wishes: {}".format(wishes))
        all_wishes = []
        if wishes:
            for wish_dict in wishes:
                all_wishes.append(get_wish_by_dict(wish_dict))
        
        logger.info("All wishes: {}".format(all_wishes))
        return all_wishes
    
    def get_wish_by_query(self, query):
        wish_dict = self.dao.get(query)
        return get_wish_by_dict(wish_dict)
    
    def get_wish_by_id(self, id):
        query = "SELECT * FROM {} WHERE id = '{}'".format(self.wish_table, id)
        return self.get_wish_by_query(query)
    
    def get_wishes_by_wish_maker(self, maker_email):
        query = "SELECT * FROM {} WHERE maker_email = '{}'".format(self.wish_table, maker_email)
        return self.get_all(query)
    
    def get_wishes_by_wish_volunteer(self, volunteer_email):
        query = "SELECT * FROM {} WHERE volunteer_email = '{}'".format(self.wish_table, volunteer_email)
        return self.get_all(query)
    
    def get_wishes_by_wish_giver(self, giver_email):
        query = "SELECT * FROM {} WHERE giver_email = '{}'".format(self.wish_table, giver_email)
        return self.get_all(query)
    
    def create_wish(self, wish):
        query = "INSERT INTO {} (`wish_name`, `wish_description`, `maker_email`) " \
                "VALUES ('{}', '{}', '{}')".format(self.wish_table, wish.wish_name, wish.wish_description, wish.maker_email)
        if self.dao.insert(query):
            # Insert successful
            return self.get_wish_by_id(wish.wish_id)
        return None