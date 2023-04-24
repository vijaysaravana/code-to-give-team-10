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

message_view = Blueprint('message_routes', __name__)
userDAO = UserDAO(baseDAO)
wishDAO = WishDAO(baseDAO)
messageDAO = MessageDAO(baseDAO)

@message_view.route('/messages')
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
        #return json.dumps({'users':unique_users}),200 
        users  = [unique_user.to_dict() for unique_user in unique_users]

        return jsonify({'users':users}),200
        #return render_template('usermessages.html', users=unique_users, this_user=user)
    #return redirect(url_for('login'))
    return jsonify({'error':'User is not logged in...'}),200 


@message_view.route('/user_conversation/<user_email>')
def user_conversation(user_email):
    # Check if user is loggedin
    if 'loggedin' in session:
        email = session['user_email']
        this_user = userDAO.get_user_by_email(email)
        other_user = userDAO.get_user_by_email(user_email)
        messages = messageDAO.get_latest_conversation_by_users(this_user.email, other_user.email)
        log.info('messages: %s', messages)

        return jsonify({'messages':[message.to_dict() for message in messages],'this_user':this_user.to_dict(),'other_user':other_user.to_dict()}),200
        #return render_template('userconversation.html', messages=messages, other_user=other_user, this_user=this_user)
    return jsonify({'error':'User is not logged in...'}),200 


@message_view.route('/send_message', methods=['POST'])
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
        messages = messageDAO.get_latest_conversation_by_users(sender_email, receiver_email)
        this_user = userDAO.get_user_by_email(sender_email)
        other_user = userDAO.get_user_by_email(receiver_email)
        return jsonify({'messages':[message.to_dict() for message in messages],'this_user':this_user.to_dict(),'other_user':other_user.to_dict()}),200
        #return render_template('userconversation.html', messages=messages, other_user=other_user, this_user=this_user)
    
    return jsonify({'error':'User is not logged in...'}),200 