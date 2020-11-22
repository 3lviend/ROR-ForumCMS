# frozen_string_literal: true

class SessionsController < ApplicationController
  # When a user logs in
  def create
    user = User.where(username: params['user']['username'])
               .or(User.where(email: params['user']['email']))
               .first

    json_response({ errors: 'Incorrect login credentials' }, 401) unless user
    return unless activated(user)

    authenticate_user(user)
  end

  # When a user logs out
  def destroy
    user = User.where(token: params['user']['token']).first
    return unless user

    user.update(token: nil)
    json_response(user: { logged_in: false })
  end

  # Checks if a user is still logged in
  def logged_in
    json_response(user: { logged_in: false }) if params['token'].blank?

    user = User.where(token: params['token']).first
    if user
      json_response(user: user_status(user))
    else json_response(user: { logged_in: false })
    end
  end

  private

  def user_status(user)
    user_with_status = user.as_json(only: %i[id username is_activated
                                             token admin_level can_post_date
                                             can_comment_date])
    user_with_status['logged_in'] = true

    user_with_status
  end

  def authenticate_user(user)
    if user.try(:authenticate, params['user']['password'])
      new_token = generate_token(user.id)
      if user.update_attribute(:token, new_token)
        json_response(user: user_status(user))
      else
        json_response({ errors: user.errors.full_messages })
      end
    else
      json_response({ errors: 'Incorrect login credentials' }, 401)
    end
  end

  def activated(user)
    unless user.is_activated
      json_response({ errors: ['Account not activated'] }, 401)
      return false
    end

    true
  end
end
