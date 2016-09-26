class ItemsController < ApplicationController






  # GET /items
  # GET /items.json
  def index
    @items = Item.paginate(:page => params[:page], :per_page => 20)
  end



   

  # GET /items/1
  # GET /items/1.json
  def show
    set_item
  end

   def dupp
       @item = Item.new(set_item)
    @item.published = true

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'El Articulo a sido creado.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end 



  def archive
    beverage = Item.find(params[:id])

    respond_to do |format|
    #  format.html # show.html.erb
      format.json { render json: beverage }
    end
    # beverage.update_attribute('archive', true)
  end

 

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    set_item
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.published = true

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'El Articulo a sido creado.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'El Articulo a sido actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy

    if @item.published == false 
      @item.published = true 
    else 
    @item.published = false
    end

    @item.save

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def search
    # @items =  Item.where(["name LIKE :tag", {:tag => params[:search][:item_name]}])
    @items =  Item.find(:all, :conditions => ['name LIKE ?', "%#{params[:search][:item_name]}%"])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      @categories = ItemCategory.find(:all)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:image_url, :sku, :name, :description, :price, :stock_amount, :cost_price, :item_category_id, :published)
    end
end
