class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(nice_params)
    if @user.save
      flash[:notice] = "yayayayaya"
    else

      render action: "index", notice: "Something went wrong. Try again."
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
  def nice_params
    {name: user_params[:name],phone_number: user_params[:phone_number].gsub(/\D/,'').to_i}
  end
end
