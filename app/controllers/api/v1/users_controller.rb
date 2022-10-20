class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: { error: "Enable to create User" }, status: 400
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user = User.find_by(id: params[:id])
    if @user
      @user.destroy
      render json: { error: "User successfully deleted" }, status: 200
    else
      render json: { error: "Enable to create User" }, status: 400
    end
  end

  # PUT /api/v1/users/:id
  def update
    @user = User.find_by(id: params[:id])
    if @user
      @user.update(user_params)
      render json: { error: "User successfully updated" }, status: 200
    else
      render json: { error: "Enable to update User" }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
