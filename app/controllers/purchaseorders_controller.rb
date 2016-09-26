class PurchaseordersController < InheritedResources::Base
  
def index
   @purchaseorders = Purchaseorder.all

  end

def new 
   @items = Item.all
   @purchaseorder = Purchaseorder.new
   @linei  = PurchaseorderItem .all 
   
   create_customer_association
end


 def edit
    @items = Item.all
    @purchaseorder = Purchaseorder.find(params[:id])
  end




 def create
    @purchaseorder = Purchaseorder.new(purchaseorder_params)
    @purchaseorder.user = current_user
    @purchaseorder.store_configuration = current_user.store_configuration
    @purchaseorder.committed = 0  ; 
    create_customer_association 

    respond_to do |format|
      if @purchaseorder.save
        format.html { redirect_to @purchaseorder, notice: 'Line compra was successfully created.'  }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end




  def create_customer_association  
     @seen_ids = params[:tag_ids].collect {|id| id.to_i} if params[:tag_ids]
     tem = Item.where(:id => params[:tag_ids] )
     @purchaseorder.items = tem
     # @sale.save
  end

 # def create_customer_association  
 #    @seen_ids = params[:tag_ids].collect {|id| id.to_i} if params[:tag_ids]
 #   tem = Item.where(:id => params[:tag_ids] )
 #    @purchaseorder.items = tem
 #    # @sale.save
 # end

   def show
    @purchaseorders = Purchaseorder.find(params[:id])
    @items = @purchaseorders.items
   

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end



   def update

    params[:post][:tag_ids] ||= []
    @purchaseorders = Purchaseorder.find(params[:id])

    respond_to do |format|
      if @purchaseorders.update_attributes(params[:post])
        format.html { redirect_to(@purchaseorders, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchaseorders.errors, :status => :unprocessable_entity }
      end
    end
  end


  




  private

    def purchaseorder_params
      params.permit(:item_id, :store_configuration_id, :user_id, :committed, :stock_id,:role_id,:tag_ids)
    end


     def set_purchaseorders
     @purchaseorders = Purchaseorder.find(params[:id])
      #@categories = EmployeeCategory.find(:all)
    end

   


end

