class User:
    def __init__(self, first_name='', last_name='', email=None, password=None,
                 created=None, updated=None, city=None, role=None):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.password = password
        self.created = created
        self.updated = updated
        self.role = role
        self.city = city

    # def __str__(self):
    #     return f'FirstName:{self.first_name}, LastName:{self.last_name}, Email:{self.email}, created:{self.created}, updated:{self.updated}, role:{self.role}, city:{self.city}'
    def __str__(self):
        return str(self.to_dict())

    def to_dict(self):
        return {'first_name': self.first_name, 'last_name': self.last_name, 
                'email': self.email, 'role': self.role, 'city': self.city}
