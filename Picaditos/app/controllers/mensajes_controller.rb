class MensajesController < ApplicationController
  before_action :set_mensaje, only: [:show, :update, :destroy]

  # GET /mensajes
  # GET /mensajes.json
  def index
    @mensajes = Mensaje.all
    render json: @mensajes, status: :ok
  end

  def my_messages
    @user = User.find(params[:user_name])
    @mensajes = Mensaje.searchByReceptor(@user.user_name)
    render json: @mensajes, status: :ok
  end
  # GET /mensajes/1
  # GET /mensajes/1.json
  def show
    @mensaje= (set_mensaje)
    render json: @mensaje, status: :ok
  end

  # POST /mensajes
  # POST /mensajes.json
  def create
    @mensaje = Mensaje.new(mensaje_params)
    if @mensaje.save
      @user=User.find(@mensaje.usuario_2_name)
      @sender= User.find(@mensaje.user_id)
      # Tell the User1Mailer to send a message incoming after save
      #User1Mailer.message_incoming(@user, @sender).deliver_now
      #render :show, status: :created, location: @mensaje
    else
      render json: @mensaje.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mensajes/1
  # PATCH/PUT /mensajes/1.json
  def update
    if @mensaje.update(mensaje_params)

    else
      render json: @mensaje.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mensajes/1
  # DELETE /mensajes/1.json
  def destroy
    @mensaje.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensaje
      @mensaje = Mensaje.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mensaje_params
      params.permit(:contenido,
      :user_id,
      :usuario_2_name,
      :fecha,
      :asunto,
      :read
      )
    end
end
