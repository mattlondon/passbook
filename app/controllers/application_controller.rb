class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected

  helper_method :current_user

  def authorize
    redirect_to_sign_in if current_user.nil?
  end

  def authorize_super
    redirect_to root_path, flash: {info: 'You must be a super user to do that.'} unless current_user.super?
  end

  def authorize_admin
    redirect_to root_path, flash: {info: 'You must be an administrator to do that.'} unless current_user.admin?
  end

  def authorize_leader
    redirect_to root_path, flash: {info: 'You must be a class leader to do that.'} unless current_user.leader?
  end

  def authorize_leader_for_junior(junior)
    redirect_to root_path, status: 403, flash: {info: 'This junior saver is not in your class.'} unless current_user.leader_of?(junior)
  end

  def authorize_senior
    redirect_to root_path, flash: {info: 'You must be an adult to do that.'} unless current_user.senior?
  end

  def authorize_senior_for_junior(junior)
    redirect_to root_path, flash: {info: 'Not your junior saver.'} unless current_user.senior_of?(junior)
  end

  private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      reset_session
      redirect_to_sign_in
    end
  end

  def redirect_to_sign_in
    session[:return_to] = request.fullpath
    alert = 'You must be signed in to do that.' unless request.fullpath == '/'
    redirect_to sign_in_url, alert: alert
  end
end
