class HomepagesController < ApplicationController
  before_action :set_homepage, only: [:show, :edit, :update, :destroy]
  layout 'login', :only => [:login]

  # GET /homepages
  # GET /homepages.json
  def index
    @homepages = Homepage.all
    @aktualny_rocnik = Rocnik.all.order('cislo DESC').first
    @aktualna_knizka = Knizka.where(rocnik: @aktualny_rocnik.cislo).order('seria ASC').order('cislo DESC').first
    @kola_l = Kolo.where(rocnik: @aktualny_rocnik.cislo, seria: 'Letná').order(:cislo)
    @knizky_l = Knizka.where(rocnik: @aktualny_rocnik.cislo, seria: 'Letná').order(:cislo)
    @seria_l = Serium.where(rocnik: @aktualny_rocnik.cislo, nazov: 'Letná').take
  end

  def login
    if !params[:commit].blank? && params[:notice] == 'login' && params[:username] == 'user' && params[:pass] == 'user'
      redirect_to homepages_path
    end
  end

  # GET /homepages/1
  # GET /homepages/1.json
  def show
  end

  # GET /homepages/new
  def new
    @homepage = Homepage.new
  end

  # GET /homepages/1/edit
  def edit
  end

  # POST /homepages
  # POST /homepages.json
  def create
    @homepage = Homepage.new(homepage_params)

    respond_to do |format|
      if @homepage.save
        format.html { redirect_to @homepage, notice: 'Homepage was successfully created.' }
        format.json { render :show, status: :created, location: @homepage }
      else
        format.html { render :new }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homepages/1
  # PATCH/PUT /homepages/1.json
  def update
    respond_to do |format|
      if @homepage.update(homepage_params)
        format.html { redirect_to @homepage, notice: 'Homepage was successfully updated.' }
        format.json { render :show, status: :ok, location: @homepage }
      else
        format.html { render :edit }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homepages/1
  # DELETE /homepages/1.json
  def destroy
    @homepage.destroy
    respond_to do |format|
      format.html { redirect_to homepages_url, notice: 'Homepage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homepage
      @homepage = Homepage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homepage_params
      params.fetch(:homepage, {})
    end
end
