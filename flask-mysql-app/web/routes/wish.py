import json
from flask import Blueprint, jsonify, session, redirect, render_template, request, url_for
from .. import baseDAO, log
import re
from web.models.User import User
from web.dao.UserDAO import UserDAO
from web.models.Wish import Wish
from web.dao.WishDAO import WishDAO

wish_view = Blueprint('wish_routes', __name__)
userDAO = UserDAO(baseDAO)
wishDAO = WishDAO(baseDAO)

# API to get wishes with query params (city, role, email)
@wish_view.route('/', methods=['GET'])
def get_wishes():
    city = request.args.get('city')
    email = request.args.get('email')
    wishes = None
    
    if email:
        user = userDAO.get_user_by_email(email)
        if user.role == 'maker':
            wishes = wishDAO.get_wishes_by_wish_maker(user.email)
        elif user.role == 'giver':
            wishes = wishDAO.get_wishes_by_wish_giver(user.email)
        elif user.role == 'volunteer':
            wishes = wishDAO.get_wishes_by_wish_volunteer(user.email)   
        elif user.role == 'staff':
            wishes = wishDAO.get_all_wishes()
        return json.dumps([wish.to_dict() for wish in wishes]), 200
    if city is not None:
        users = userDAO.get_users_by_city(city, role='maker')
        wish_list = []
        for user in users:
            wishes = wishDAO.get_wishes_by_wish_maker(user.email)
            wish_list.append(wishes)
        flat_wish_list = [item for sublist in wish_list for item in sublist]
        return json.dumps([wish.to_dict() for wish in flat_wish_list])
    else:
        wishes = wishDAO.get_all_wishes()
    if wishes:
        return json.dumps([wish.to_dict() for wish in wishes]), 200
    
    return jsonify([]), 200

# API to create a wish
@wish_view.route('/', methods=['POST'])
def create_wish():
    wish = Wish(**request.json)
    user = userDAO.get_user_by_email(wish.maker_email)
    if user is None or user.role != 'maker':
        return json.dumps({'error': 'user foes not exist or user is not a wish maker'}), 400
    
    log.info("wish: {}".format(wish))
    wish_created = wishDAO.create_wish(wish)
    if wish_created:
        return json.dumps(wish_created.to_dict()), 201 
    return json.dumps({'error': 'Wish creation failed'}), 400