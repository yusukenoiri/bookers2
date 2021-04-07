class UsersController < ApplicationController
  def new
  end

  def create
  end

  def index
    @user =User.find(params[])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end
  
  def edit
  end
  def updated
  end
  
end
