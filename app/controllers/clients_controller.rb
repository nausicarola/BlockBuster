class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index
    # @clients = Client.all
    @clients = Client.page(params[:page]).per(5)
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        flash[:error] = "Client was successfully created."
        format.html { redirect_to client_url(@client)}
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        flash[:error] = "Client was successfully updated."
        format.html { redirect_to client_url(@client) }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client = Client.find(params[:id])

    if @client.movies.any?
      flash[:error] = "No se puede borrar el cliente porque tiene películas asignadas."
      respond_to do |format|
        format.html { redirect_to clients_url }
        format.json { render json: { error: "No se puede borrar el cliente porque tiene películas asignadas." }, status: :unprocessable_entity }
      end
    else
      @client.destroy
      flash[:error] = "Cliente fue eliminado exitosamente."
      respond_to do |format|
        format.html { redirect_to clients_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :age)
    end
end
