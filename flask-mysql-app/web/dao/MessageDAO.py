from web.models.User import User
from web.models.Message import Message
import logging
logger = logging.getLogger(__name__)

def get_user_by_dict(user_dict):
    user = None
    if user_dict:
        user = User(**user_dict)
    return user

def get_message_by_dict(message_dict):
    message = None
    if message_dict:
        message = Message(**message_dict)
    return message

class MessageDAO:

    def __init__(self, dao):
        self.dao = dao
        self.user_table = "users"
        self.message_table = "messages"
  
    def get_all(self, query):
        messages = self.dao.get_all(query)
        logger.info("Messages: {}".format(messages))
        all_messages = []
        if messages:
            for message_dict in messages:
                all_messages.append(get_message_by_dict(message_dict))
        return all_messages

    def get_user(self, email, password):
        query = "SELECT * FROM {} WHERE email = '{}' AND password = '{}'".format(self.user_table, email, password)
        return self.get_user_by_query(query)

    def get_user_by_email(self, email):
        query = "SELECT * FROM {} WHERE email = '{}'".format(self.table, email)
        return self.get_user_by_query(query)

    def create_user(self, user):
        query = "INSERT INTO {} (`first_name`, `last_name`, `email`, `password`, `role`, `city`) " \
                "VALUES ('{}', '{}', '{}', '{}', '{}', '{}')".format(self.user_table, user.first_name, user.last_name, user.email,
                                                               user.password, user.role, user.city)
        if self.dao.insert(query):
            # Insert successful
            return self.get_user_by_email(user.email)
        return None
    
    def create_message(self, message):
        query = "INSERT INTO {} (`sender_email`, `receiver_email`, `message`) " \
                "VALUES ('{}', '{}', '{}')".format(self.message_table, message.sender_email, message.receiver_email, message.message)
        if self.dao.insert(query):
            # Insert successful
            # return self.get_message_by_query(query)
            logger.info("Message created successfully")
        return None
    
    def get_messages_sent_by_user(self, user):
        query = "SELECT * FROM {} WHERE sender_email = '{}'".format(self.message_table, user.email)
        return self.get_all(query)
    
    def get_messages_received_by_user(self, user):
        query = "SELECT * FROM {} WHERE receiver_email = '{}'".format(self.message_table, user.email)
        return self.get_all(query)
    
    def get_messages(self, sender_email, receiver_email):
        query = "SELECT * FROM {} WHERE sender_email = '{}' AND receiver_email = '{}'".format(self.message_table, sender_email, receiver_email)
        return self.get_all(query)
    
    def get_messages_by_user_email(self, user_email):
        query = "SELECT * FROM {} WHERE sender_email = '{}' OR receiver_email = '{}'".format(self.message_table, user_email, user_email)
        return self.get_all(query)
    
    def get_conversation_by_users(self, sender_email, receiver_email):
        query = "SELECT * FROM {} WHERE (sender_email = '{}' AND receiver_email = '{}') OR (sender_email = '{}' AND receiver_email = '{}')".format(self.message_table, sender_email, receiver_email, receiver_email, sender_email)
        return self.get_all(query)
    
    def get_latest_conversation_by_users(self, sender_email, receiver_email):
        query = "SELECT * FROM {} WHERE (sender_email = '{}' AND receiver_email = '{}') OR (sender_email = '{}' AND receiver_email = '{}') order by message_sent DESC limit 10".format(self.message_table, sender_email, receiver_email, receiver_email, sender_email)
        return self.get_all(query)