class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include PublicActivity::StoreController
  include Pundit::Authorization
  protect_from_forgery
  before_action :set_global_variables, if: :user_signed_in?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
