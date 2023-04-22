class Location:
    def __init__(self, city='', latitude='', longitude=''):
        self.city = city
        self.latitude = latitude
        self.longitude = longitude

    def __str__(self):
        return f'City - {self.city}: {self.latitude}, {self.longitude}'