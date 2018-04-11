class PartidosController < ApplicationController
  before_action :set_partido, only: [:show, :update, :destroy]

  # GET /partidos
  # GET /partidos.json
  def index
    @partidos = Partido.all
  end

  # GET /partidos/1
  # GET /partidos/1.json
  def show
  end

  # POST /partidos
  # POST /partidos.json
  def create
    @partido = Partido.new(partido_params)

    if @partido.save
      render :show, status: :created, location: @partido
    else
      render json: @partido.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /partidos/1
  # PATCH/PUT /partidos/1.json
  def update
    if @partido.update(partido_params)
      render :show, status: :ok, location: @partido
    else
      render json: @partido.errors, status: :unprocessable_entity
    end
  end

  # DELETE /partidos/1
  # DELETE /partidos/1.json
  def destroy
    @partido.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partido
      @partido = Partido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partido_params
      params.fetch(:partido, {})
    end
end