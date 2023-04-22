class Wish:
    def __init__(self, wish_name='', wish_description='', 
                 wish_id=None, wish_status='pending',
                 wish_created=None, wish_updated=None, maker_email=None, 
                 volunteer_email=None, giver_email=None):
        self.wish_name = wish_name
        self.wish_description = wish_description
        self.wish_id = wish_id
        self.wish_status = wish_status
        self.wish_created = wish_created
        self.wish_updated = wish_updated
        self.maker_email = maker_email
        self.volunteer_email = volunteer_email
        self.giver_email = giver_email

    def __str__(self):
        return f'Wish - {self.wish_id}: {self.wish_name}'

    def to_dict(self):
        return {'wish_name': self.wish_name, 'wish_description': self.wish_description,
                'wish_id': self.wish_id, 'wish_status': self.wish_status, 'maker_email': self.maker_email,
                'volunteer_email': self.volunteer_email, 'giver_email': self.giver_email}