class UsersController <ApplicationController 
  # before_action :require_login, only: [:show]

  def new 
    @user = User.new
  end 

  def show 
    @user = User.find(params[:id])

    # if !current_user
    #   flash[:error] = "You must be logged in or registered to access a user's dashboard."
    #   redirect_to root_path
    # end
  end 

  def create 
    user = User.new(user_params)
    session[:user_id] = user.id
    if user.save
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:user_location] = params[:location]
      flash[:success] = "Hello, #{user.name}!"
      redirect_to user_path("#{user.id}")
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout_user
    session.delete(:user_id)
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
 end

  private 

  # def require_login
  #   unless current_user
  #     flash[:alert] = "You must be logged in to access the user's dashboard."
  #     redirect_to root_path
  #   end
  # end

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
  end 
end 