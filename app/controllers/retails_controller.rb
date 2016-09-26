class RetailsController < ApplicationController
  before_action :set_retail, only: [:show, :edit, :update, :destroy]

  # GET /retails
  # GET /retails.json
  def index
    @retails = Retail.paginate(:page => params[:page], :per_page => 20).where(:published => true)
  end

  # GET /retails/1
  # GET /retails/1.json
  def show
    set_retail
  end

  # GET /retails/new
  def new
    @retail = Retail.new
  end

  # GET /retails/1/edit
  def edit
    set_retail
  end

  # POST /retails
  # POST /retails.json
  def create
    @retail = Retail.new(retail_params)
    @retail.published = true

    respond_to do |format|
      if @retail.save
        format.html { redirect_to @retail, notice: 'La Sucursal a sido creada.' }
        format.json { render action: 'show', status: :created, location: @retail }
      else
        format.html { render action: 'new' }
        format.json { render json: @retail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /retails/1
  # PATCH/PUT /retails/1.json
  def update

    respond_to do |format|
      if @retail.update(retail_params)
        format.html { redirect_to @retail, notice: 'La Sucursal a sido actualizada.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @retail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retails/1
  # DELETE /retails/1.json
  def destroy
    @retail.published = false
    @retail.save

    respond_to do |format|
      format.html { redirect_to retails_url }
      format.json { head :no_content }
    end
  end

  def search
    # @retails =  Retail.where(["name LIKE :tag", {:tag => params[:search][:retail_name]}])
    @retails =  Retail.find(:all, :conditions => ['name LIKE ?', "%#{params[:search][:retail_name]}%"])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retail
      @retail = Retail.find(params[:id])
     # @categories = RetailCategory.find(:all)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def retail_params
      params.require(:retail).permit(:name, :address, :phone, :published)
    end
end
