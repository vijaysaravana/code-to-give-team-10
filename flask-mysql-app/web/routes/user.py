import json
from flask import Blueprint, jsonify, session, redirect, render_template, request, url_for
from web.dao.WishDAO import WishDAO
from .. import baseDAO, log
import re
from web.models.User import User
from web.dao.UserDAO import UserDAO
from web.models.Wish import Wish
from web.dao.WishDAO import WishDAO
from web.dao.MessageDAO import MessageDAO
from web.models.Message import Message

user_view = Blueprint('user_routes', __name__)
userDAO = UserDAO(baseDAO)
wishDAO = WishDAO(baseDAO)
messageDAO = MessageDAO(baseDAO)

# API to get users with query params (city, role, email)
@user_view.route('/users', methods=['GET'])
def get_users():
    city = request.args.get('city')
    role = request.args.get('role')
    email = request.args.get('email')
    users = None
    if email:
        user = userDAO.get_user_by_email(email)
        return json.dumps(user.to_dict()), 200
    elif city is not None:
        users = userDAO.get_users_by_city(city, role)
        return json.dumps([user.to_dict() for user in users])
    elif role is not None:
        users = userDAO.get_users_by_role(role)
    else:
        users = userDAO.get_all_users()
    if users:
        return json.dumps([user.to_dict() for user in users]), 200
    
    return jsonify([]), 200

# API to create user
@user_view.route('/usersignup', methods=['POST'])
def create_user():
    user = User(**request.json)
    log.info("user: {}".format(user))
    existing_user = userDAO.get_user(user.email, user.password)
    if existing_user:
        return json.dumps({'error': 'User already exists'}), 400
    user = userDAO.create_user(user)
    if user:
        return json.dumps(user.to_dict()), 201 
    return json.dumps({'error': 'User creation failed'}), 400

@user_view.route('/', methods=['GET', 'POST'])
def login():
    msg = ''
    # Check if "email" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form:
        # Create variables for easy access
        email = request.form['email']
        password = request.form['password']
        if baseDAO is None:
            log.info("baseDAO is None!")

        if userDAO is None:
            log.info("userDAO is None!")
        # Check if user exists using MySQL
        user = userDAO.get_user(email, password)
        if user:
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            session['user_email'] = user.email
            session['user_fullname'] = user.first_name + ' ' + user.last_name
            session['user_role'] = user.role
            session['user_city'] = user.city
            # Redirect to home page
            return redirect(url_for('user_routes.home'))
        else:
            msg = 'User does not exist or username/password incorrect'
    return render_template('index.html', msg=msg)

@user_view.route('/userlogin', methods=['GET', 'POST'])
def userlogin():
    jsonrequest = request.get_json()
    email = jsonrequest['email']
    password = jsonrequest['password']

    if request.method == 'POST' and email is not None and password is not None:
        if baseDAO is None:
            log.info("baseDAO is None!")

        if userDAO is None:
            log.info("userDAO is None!")

        user = userDAO.get_user(email, password)
        if user:
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            session['user_email'] = user.email
            session['user_fullname'] = user.first_name + ' ' + user.last_name
            session['user_role'] = user.role
            session['user_city'] = user.city
            # Redirect to home page
            return json.dumps(user.to_dict()), 200
        else:
            msg = 'User does not exist or username/password incorrect'
    return json.dumps({'error': 'User does not exist or username/password incorrect'}), 400

@user_view.route('/logout')
def logout():
    print("logout")
    session.pop('loggedin', None)
    session.pop('user_email', None)
    session.pop('user_fullname', None)
    session.pop('user_role', None)
    session.pop('user_city', None)
    # Redirect to login page
    return redirect(url_for('user_routes.login'))


@user_view.route('/register', methods=['GET', 'POST'])
def register():
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form \
            and 'first_name' in request.form:
        # Create variables for easy access
        email = request.form['email']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        password = request.form['password']
        admin = False

        print(userDAO)
        user = userDAO.get_user_by_email(email)

        # If account exists show error and validation checks
        if user:
            msg = 'Account already exists!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address!'
        elif not first_name or not password or not email:
            msg = 'Please fill out the form!'
        else:
            user_dict = {'first_name': first_name,
                         'last_name': last_name,
                         'email': email,
                         'password': password,
                         'admin': admin}

            user = User(**user_dict)
            print(user)
            userDAO.create_user(user)
            msg = 'You have successfully registered!'

    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)


@user_view.route('/home')
def home():
    # Check if user is loggedin
    if 'loggedin' in session:
        # User is loggedin show them the home page
        return render_template('home.html', user_fullname=session['user_fullname'], user_role=session['user_role'],
                               user_city=session['user_city'], user_email=session['user_email'])
    # User is not loggedin redirect to login page
    return redirect(url_for('user_routes.login'))


@user_view.route('/profile')
def profile():
    print("Profile")
    # Check if user is loggedin
    if 'loggedin' in session:
        email = session['user_email']
        user = userDAO.get_user_by_email(email)
        return render_template('profile.html', user=user)
    return redirect(url_for('login'))


@user_view.route('/wishesmade')
def wishesmade():
    print("Profile")
    # Check if user is loggedin
    if 'loggedin' in session:
        email = session['user_email']
        user = userDAO.get_user_by_email(email)
        user_wishes = wishDAO.get_wishes_by_wish_maker(user.email)
        return render_template('wishesmade.html', user=user, wishes=user_wishes)
    return redirect(url_for('login'))


@user_view.route('/messages')
def get_messages():
    # Check if user is loggedin
    if 'loggedin' in session:
        email = session['user_email']
        user = userDAO.get_user_by_email(email)
        messages = messageDAO.get_messages_by_user_email(user.email)
        user_set = set([message.sender_email for message in messages])
        unique_users = [userDAO.get_user_by_email(user_email) for user_email in user_set]
        log.info('unique users: %s', unique_users)
        # unique_users.remove(user)
        return render_template('usermessages.html', users=unique_users, this_user=user)
    return redirect(url_for('login'))


@user_view.route('/user_conversation/<user_email>')
def user_conversation(user_email):
    # Check if user is loggedin
    if 'loggedin' in session:
        email = session['user_email']
        this_user = userDAO.get_user_by_email(email)
        other_user = userDAO.get_user_by_email(user_email)
        messages = messageDAO.get_conversation_by_users(this_user.email, other_user.email)
        log.info('messages: %s', messages)
        return render_template('userconversation.html', messages=messages, other_user=other_user, this_user=this_user)
    return redirect(url_for('login'))

@user_view.route('/send_message', methods=['POST'])
def send_message():
    # Check if user is loggedin
    if request.method == 'POST' and 'message_sender' in request.form \
        and 'message_receiver' in request.form and 'message_text' in request.form:
        # Create variables for easy access
        sender_email = request.form['message_sender']
        receiver_email = request.form['message_receiver']
        message_text = request.form['message_text']
        message = Message(sender_email=sender_email, receiver_email=receiver_email, message=message_text)
        log.info('message trying to be sent: %s', message)
        if baseDAO is None:
            log.info("baseDAO is None!")

        if userDAO is None:
            log.info("userDAO is None!")
        # Check if user exists using MySQL
        messageDAO.create_message(message)
        log.info('message sent!: %s', message)
        messages = messageDAO.get_conversation_by_users(sender_email, receiver_email)
        this_user = userDAO.get_user_by_email(sender_email)
        other_user = userDAO.get_user_by_email(receiver_email)
        return render_template('userconversation.html', messages=messages, other_user=other_user, this_user=this_user)
    
    return render_template('index.html', msg="")