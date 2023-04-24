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
    city, email = None, None
    jsonrequest = request.get_json()
    if 'city' in jsonrequest:
        city = jsonrequest['city']
    if 'email' in jsonrequest:
        email = jsonrequest['email']
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

# API to create a wish - webapp
@wish_view.route('/createwishweb', methods=['POST'])
def create_wish_web():
    msg = ''
    wish_name = request.form['wish_name']
    wish_description = request.form['wish_description']
    maker_email = request.form['maker_email']
    log.info("Printin maker email: {}".format(maker_email))
    wish = Wish(wish_name=wish_name, wish_description=wish_description, maker_email=maker_email)
    user = userDAO.get_user_by_email(wish.maker_email)
    if user is None or user.role != 'maker':
        return json.dumps({'error': 'user foes not exist or user is not a wish maker'}), 400
    
    log.info("wish: {}".format(wish))
    wish_created = wishDAO.create_wish(wish)
    wishmaker = userDAO.get_user_by_email(wish.maker_email)
    if wish_created:
        return render_template('trackwish.html', wish=wish,  wishmaker=wishmaker, wishgiver=None, wishvolunteer=None
                               ,user_email=maker_email, users=[])
    else:
            msg = 'User does not exist or username/password incorrect'
    return render_template('index.html', msg=msg)

@wish_view.route('/makeawish', methods=['GET'])
def make_a_wish():
    return render_template('makeawish.html', user_email=session['user_email'])

# Wish tracker
@wish_view.route('/trackallwishes', methods=['GET'])
def track_all_wishes():
    wishes_made = wishDAO.get_all_wishes()
    user = userDAO.get_user_by_email(session['user_email'])

    return render_template('trackallwishes.html', user=user, user_email=session['user_email'], wishes=wishes_made)

# API to track a wish
@wish_view.route('/wish_status/<int:wish_id>', methods=['GET'])
def wish_status(wish_id):
    wish = wishDAO.get_wish_by_id(wish_id)
    wishmaker = userDAO.get_user_by_email(wish.maker_email)
    wishgiver = userDAO.get_user_by_email(wish.giver_email)
    wishvolunteer = userDAO.get_volunteers()[0]
    users = []
    if wishmaker:
        users.append(wishmaker)
    if wishgiver:
        users.append(wishgiver)

    if wish:
        return render_template('trackwish.html', wish=wish,  wishmaker=wishmaker, wishgiver=wishgiver, wishvolunteer=wishvolunteer
                               ,user_email=session['user_email'], users=users)
    return json.dumps({'error': 'Wish not found'}), 400


# TODO - API to update a wish status (For wish tracking)
# @wish_view.route('/<wish_id>', methods=['PUT'])
# def update_wish(wish_id):
#     wish = Wish(**request.json)
#     wish_id = wish_id
#     wish_updated = wishDAO.update_wish(wish, wish_id)
#     if wish_updated:
#         return json.dumps(wish_updated.to_dict()), 200
#     return json.dumps({'error': 'Wish update failed'}), 400