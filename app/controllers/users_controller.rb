class UsersController < ApplicationController
  before_action :authorize_request
  before_action :load_user, only: [:update, :destroy]
  
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    @user =  params[:id].present? ? User.find_by_id(params[:id]) : @current_user
    if @user.nil?
      render json: {errors: "User does not exist"}, status: :unprocessable_entity
    else
      render json: @user, status: :ok
    end
  end

  def create
    @user = User.new(user_params)
    @user.skip_some_callbacks = true
    if @user.save
      @user = { id: @user.id, username: @user.username, email: @user.email, role: @user.role, password: @user.password}
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: {message: "User successfully deleted"}, status: :ok 
  end

  def change_password
    @user = @current_user
    if params[:password] == params[:password_confirmation]
      @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      render json: @user, status: :ok
    else
      render json: {errors: "Password not match"}, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = User.find_by_id(params[:id])
    if @user.nil?
      return render json: {errors: "User does not exist"}, status: :not_found 
    end
  end

  def user_params
    params.permit( :username, :email, :role, :password, :password_confirmation)
  end
end
