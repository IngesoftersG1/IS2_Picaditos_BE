class UsersController < ApplicationController
  include Knock::Authenticable
  #before_action :authenticate_user
  #before_action :set_user, only: [:index]
  # GET /users
  # GET /users.json
  def index
      @users = User.all
      render json: @users, status: :ok
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user= set_user
    render json: @user, status: :ok
   
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)   
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_now
        format.html{redirect_to(@user, notice: 'El usuario fue creado correctamente.') }
        format.json {render json: @user, status: :created, location: @user}
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
   
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    before_action :authenticate_user
    @user.destroy
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit( :user_name,
      :nombres,
      :apellidos,
      :email,
      :telefono,
      :ubicacion_id,
      :fecha_nacimiento,
      :page,
      :password,
      :password_confirmation,
      :picture
      )
    end
end
