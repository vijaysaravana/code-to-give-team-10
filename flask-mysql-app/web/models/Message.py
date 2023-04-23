class Message:
    def __init__(self, message_id=None, sender_email='', receiver_email='', message='', message_sent=None):
        self.message_id = message_id
        self.sender_email = sender_email
        self.receiver_email = receiver_email
        self.message = message
        self.message_sent = message_sent

    # def __str__(self):
    #     return f'FirstName:{self.first_name}, LastName:{self.last_name}, Email:{self.email}, created:{self.created}, updated:{self.updated}, role:{self.role}, city:{self.city}'
    def __str__(self):
        return str(self.to_dict())

    def to_dict(self):
        return {'sender_email': self.sender_email, 'receiver_email': self.receiver_email,
                'message': self.message, 'message_sent': self.message_sent, 'message_id': self.message_id}