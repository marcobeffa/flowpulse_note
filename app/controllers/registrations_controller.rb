# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  before_action :resume_session, only: :new
  before_action :set_user, only: [ :edit, :update ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
    redirect_to root_url, notice: "You are already signed in." if authenticated?
  end

  def create
    user = User.new(user_params)
    if user.save
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Signed up."
    else
      redirect_to new_registration_url(email_address: params[:email_address]), alert: user.errors.full_messages.to_sentence
    end
  end

  def edit
    # Renderizza il form di modifica
  end

  def update
    if @user.update(user_params)
      redirect_to after_authentication_url, notice: "Account updated successfully."
    else
      render :edit, alert: @user.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end



  private

  def set_user
    @user = Current.user
    redirect_to new_session_url, alert: "You must be signed in to edit your account." unless @user
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :username)
  end
end
