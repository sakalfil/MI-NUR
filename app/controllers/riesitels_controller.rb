class RiesitelsController < ApplicationController
  before_action :set_riesitel, only: [:show, :edit, :update, :destroy]

  # GET /riesitels
  # GET /riesitels.json
  def index
    @riesitels = Riesitel.all
  end

  # GET /riesitels/1
  # GET /riesitels/1.json
  def show
  end

  # GET /riesitels/new
  def new
    @riesitel = Riesitel.new
  end

  # GET /riesitels/1/edit
  def edit
  end

  # POST /riesitels
  # POST /riesitels.json
  def create
    @riesitel = Riesitel.new(riesitel_params)

    respond_to do |format|
      if @riesitel.save
        format.html { redirect_to @riesitel, notice: 'Riesitel was successfully created.' }
        format.json { render :show, status: :created, location: @riesitel }
      else
        format.html { render :new }
        format.json { render json: @riesitel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /riesitels/1
  # PATCH/PUT /riesitels/1.json
  def update
    respond_to do |format|
      if @riesitel.update(riesitel_params)
        format.html { redirect_to riesitels_path, notice: 'riesitel_update' }
        format.json { render :show, status: :ok, location: @riesitel }
      else
        format.html { render :edit }
        format.json { render json: @riesitel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /riesitels/1
  # DELETE /riesitels/1.json
  def destroy
    @riesitel.destroy
    respond_to do |format|
      format.html { redirect_to riesitels_url, notice: 'riesitel_delete' }
      format.json { head :no_content }
    end
  end

  def add_riesitels_to_seria
    if !params[:riesitels].blank?
      seria = Serium.find(params[:seria_id])
      ids = []
      params[:riesitels].each do |rID|
        riesitel = Riesitel.find(rID)
        rSerie = RiesitelSerium.create(riesitel: riesitel, seria: seria.rocnik.to_s + '. ' + seria.nazov, seria_id: seria.id)
        ids << rSerie.id
      end
      redirect_to url_for(:controller => 'riesitel_seria', :action => 'riesitelia_serie', riesitelia_ids: ids), notice: 'riesitel_add'
      return
    end
    redirect_to riesitels_url, notice: "riesitel_not_selected"
  end

  def add_riesitels
    @riesiteliaToAdd = []
    save = false
    if !params[:meno].blank?
      save = true if params[:commit] == "Uložiť"
      params[:meno].each_with_index do |meno, i|
        if save and meno.blank? and params[:priezvisko][i].blank? and params[:adresa][i].blank? and params[:dat_nar][i].blank? and params[:cislo][i].blank? and
            params[:cislo_rodic][i].blank? and params[:email][i].blank?
          next
        end
        if save and (meno.blank? or params[:priezvisko][i].blank? or params[:adresa][i].blank? or params[:dat_nar][i].blank?)
          save = false
          @notice = 'Polia meno, priezvisko, adresa a dátum narodenia nemôžu byť prázdne!'
        end
        newRiesitel = Riesitel.new
        newRiesitel.meno = meno
        newRiesitel.priezvisko = params[:priezvisko][i]
        newRiesitel.adresa = params[:adresa][i]
        newRiesitel.datum_narodenia = params[:dat_nar][i]
        newRiesitel.telefon = params[:cislo][i]
        newRiesitel.telefon_rodic = params[:cislo_rodic][i]
        newRiesitel.email = params[:email][i]
        @riesiteliaToAdd << newRiesitel
      end
      if save
        if @riesiteliaToAdd.size == 0
          redirect_to riesitels_path
        else
          @riesiteliaToAdd.each do |r|
            r.save
          end
          redirect_to riesitels_path, notice: "riesitel_add"
        end
        return
      end
    end
    render :action => 'new'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_riesitel
    @riesitel = Riesitel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def riesitel_params
    params.require(:riesitel).permit(:meno, :priezvisko, :adresa, :datum_narodenia, :telefon, :telefon_rodic, :email)
  end
end
