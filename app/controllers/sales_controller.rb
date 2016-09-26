class SalesController < ApplicationController
  before_action :set_configurations

  def index
     @sales = Sale.where( :user_id => current_user.id  ).where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def new

  ultimo = Sale.where(:user_id => current_user)
      if ultimo.last.line_items.count != nil 

     if ultimo.last.line_items.count == 0 
     redirect_to :controller => 'sales', :action => 'edit', :id => ultimo.last.id
    else 
    @sale = Sale.create
    @sale.store_configuration = current_user.store_configuration
    @sale.user_id = current_user.id
    @sale.save
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end 
else 
  @sale = Sale.create
    @sale.store_configuration = current_user.store_configuration
    @sale.user_id = current_user.id
    @sale.save
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end
end 


  def show
   set_sale
   @ultimo = Sale.last.id

  end

  def crear
    @sale = Sale.create
    @sale.store_configuration = current_user.store_configuration
    @sale.save
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end 

   


  def edit 
    @customer  =  Customer.pluck(:last_name)
    @employes =   Employee.pluck (:name)
    @collection = [ "One", "dos", "tres", "cuatro"]. join ( ',')
    @employes=   @employes.join(',')
    @customer = @customer.join(',')
    set_sale
    populate_items
    populate_customers
    populate_employee
    @sale.line_items.build
    @sale.payments.build
    @custom_item = Item.new
    @custom_customer = Customer.new
    @employye_customer = Employee.new
    @items = ItemCategory.all
     if  !(@sale.employee == nil  ) 
       @employes_re = "nil"
    end 
  end

    def suma
     set_sale
    populate_items
    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity += 1
    line_item.save
    update_line_item_totals(line_item)
    update_totals
    respond_to do |format|
      format.js { ajax_refresh }
     end
  end


  

  

  def destroy
    set_sale

    if current_user.can_update_items == true
     line_item = LineItem.where(:sale_id => params[:sale_id]).first
    line_item.each do |item|
       item.quantity -= 1
    if item.quantity <= 0
      item.destroy
    else
      item.save
      update_line_item_totals(item)
    end
    return_item_to_stock(params[:item_id], 1)
    update_totals
    end

    else
      redirect_to @sale, notice: 'sales.'
    end
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Venta eliminada.'}
      format.json { head :no_content }
    end
  end
 

  # searched Items
  def update_line_item_options
    set_sale
    populate_items

    if params[:search][:item_category].blank?
      @available_items = Item.find(:all, :conditions => ['name ILIKE ? AND published = true OR description ILIKE ? AND published = true OR sku ILIKE ? AND published = true', "%#{params[:search][:item_name]}%", "%#{params[:search][:item_name]}%", "%#{params[:search][:item_name]}%"], :limit => 5)
    elsif params[:search][:item_name].blank?
      @available_items = Item.where(:item_category_id => params[:search][:item_category]).limit(5)
    else
      @available_items = Item.find(:all, :conditions => ['name ILIKE ? AND published = true AND item_category_id = ? OR description ILIKE ? AND published = true AND item_category_id = ? OR sku ILIKE ? AND published = true AND item_category_id = ?', "%#{params[:search][:item_name]}%", "#{params[:search][:item_category]}", "%#{params[:search][:item_name]}%", "#{params[:search][:item_category]}", "%#{params[:search][:item_name]}%", "#{params[:search][:item_category]}"], :limit => 5)
    end

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def update_customer_options
    set_sale
    populate_items
    @available_customers = Customer.find(:all, :conditions => ['last_name ILIKE ? AND published = true OR first_name ILIKE ? AND published = true OR email_address ILIKE ? AND published = true OR phone_number ILIKE ? AND published = true', "%#{params[:search][:customer_name]}%","%#{params[:search][:customer_name]}%", "%#{params[:search][:customer_name]}%", "%#{params[:search][:customer_name]}%"], :limit => 5)

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def create_customer_association
    set_sale
    unless @sale.blank? || params[:customer_id].blank?
      @sale.customer_id = params[:customer_id]
      @sale.save
    end
    
  end
 
  # Add a searched Item
  def create_line_item
    set_sale
    populate_items
     @numero = @sale.line_items.count
   
    item2 = Item.find_by sku: params[:item_id]
    existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", item2.id, @sale.id).first 
    if existing_line_item.blank? ||  existing_line_item.discount !=  nil
      line_item = LineItem.new(:item_id => item2.id, :sale_id => params[:sale_id], :quantity => params[:quantity])
      line_item.price = line_item.item.price
      line_item.save

      remove_item_from_stock(item2.id, 1)
      update_line_item_totals(line_item)
    else
      existing_line_item.quantity += 1
      existing_line_item.save

      remove_item_from_stock(item2.id, 1)
      update_line_item_totals(existing_line_item)
    end

    update_totals
    return render(:file => 'sales/ajax_reload.js.erb')

   

  end


  def uno 
     set_sale
if params[:search][:item_name] 
   tem  = params[:search][:item_name]
   tem2 = tem .scan(/\w+/)
   @verga = tem2.count
   contador =tem2.count
   @texto = tem2[contador-1]
   @contado =  contador
   else
   end
      todos = Item.all 
   if params[:search][:item_category].blank?
      tem2.each do | conta  |
      @available_itemsTEM = searc(conta , todos)
      todos = @available_itemsTEM
     end 
    elsif params[:search][:item_name].blank?
         tem2.each do | conta  |
         @available_itemsTEM = searc(conta , todos)
         todos = @available_itemsTEM
    end 
       else
       tem2.each do | conta  |
       @available_itemsTEM = searca(conta , todos)
       todos = @available_itemsTEM
     end 
    end

     @available_items = @available_itemsTEM.limit(25)
    # @available_items = @available_items.reorder('name ASC')
 
   #if ( @available_items .count ==   100  )
   # item2 = @available_items.last   
   # existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", item2.id, @sale.id).first 
   # if existing_line_item.blank?
   # line_item = LineItem.new(:item_id => item2.id, :sale_id => params[:sale_id], :quantity => params[:quantity])
    #  line_item.price = line_item.item.price
    #  line_item.save
    #  remove_item_from_stock(item2.id, 1)
    #  update_line_item_totals(line_item)
    #else
    #  existing_line_item.quantity += 1
    #  existing_line_item.save
    #  remove_item_from_stock(item2.id, 1)
    #  update_line_item_totals(existing_line_item)
   # end
   # update_totals
   # end 
      respond_to do |format|
     format.js { ajax_refresh }
     format.json { render :json => @available_items }
    end
  end 


    def searc(query , todos)

     todos.where("(name||description) LIKE :q", :q => "%#{query}%") 
    # todos.where('model ILIKE ? AND published = true AND name ILIKE ? AND published = true OR description ILIKE ? AND published = true OR sku ILIKE ? AND published = true',"%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
     end

     def searca(query , todos )
     todos= todos.where(item_category_id:  params[:search][:item_category])
     @cuantos = todos.count
     todos.where("(name || model || description || sku ) LIKE :q", :q => "%#{query}%")
     end
   



def search
     set_sale
    populate_items

    searchitem  = Item.where(sku: params[:sku])

   if  searchitem.each  >= 1 

    existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", searchitem.id, @sale.id).first
    
    if existing_line_item.blank?
      line_item = LineItem.new(:item_id => searchitem.id , :sale_id =>  @sale.id, :quantity => searchitem.quantity)
      line_item.price = line_item.item.price
      line_item.save

      remove_item_from_stock(searchitem.id, 1)
      update_line_item_totals(line_item)
    else
      existing_line_item.quantity += 1
      existing_line_item.save

      remove_item_from_stock(searchitem.id, 1)
      update_line_item_totals(existing_line_item)
    end
    update_totals
    end
    respond_to do |format|
      format.js { ajax_refresh }
    end
  end 
  def  






  # Remove Item
  def removeperson
    set_sale
    populate_items
    line_item = LineItem.where(sale_id: params[:sale_id], item_id: params[:item_id]).first
    line_item.quantity -= 1
    if line_item.quantity <= 0
      line_item.destroy
    else
      line_item.save
      update_line_item_totals(line_item)
    end
    return_item_to_stock(params[:item_id], 1)
    update_totals
    respond_to do |format|
      format.js { ajax_refresh }
    end
  end



 # Add one Item  pero no elimina  del stoc total

  def add_item
    set_sale
    populate_items
    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity -= 1
    if line_item.quantity <= 0
      line_item.destroy
    else
      line_item.save
      update_line_item_totals(line_item)
    end
    remove_item_from_stock(params[:item_id], 1)
    update_totals
    respond_to do |format|
      format.js { ajax_refresh }
     end
  end


  def descuento

    @saledes = params[:sale_id] 
    @itemds = params[:item_id]
    descu = params[:discount]
    @descuentot =descu    
    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).last
    line_item.discount = params[:discount]
    line_item.save
     update_line_item_descuento(line_item)
     @dato1 = line_item.discount
     update_totals
    respond_to do |format|
    format.js { ajax_refresh }
    end
  end 





  def update_line_item_descuento(line_item)  
     temitem = Item.find_by(id: line_item.item_id)
     line_item.total_price = (temitem.price * line_item.quantity)-(temitem.price* line_item.discount)
     line_item.save
  end


def create_custom_item
    set_sale
    populate_items

    custom_item = Item.new
    custom_item.sku = "CI#{(rand(5..30) + rand(5..30)) * 11}_#{(rand(5..30) + rand(5..30)) * 11}"
    custom_item.name = params[:custom_item][:name]
    custom_item.description = params[:custom_item][:description]
    custom_item.price = params[:custom_item][:price]
    custom_item.stock_amount = params[:custom_item][:stock_amount]
    custom_item.item_category_id = params[:custom_item][:item_category_id]

    custom_item.save

    custom_line_item = LineItem.new(:item_id => custom_item.id, :sale_id => @sale.id, :quantity => custom_item.stock_amount, :price => custom_item.price )
    custom_line_item.total_price = custom_item.price * custom_item.stock_amount
    custom_line_item.save

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def create_custom_customer
    set_sale
    populate_items

    custom_customer = Customer.new
    custom_customer.first_name = params[:custom_customer][:first_name]
    custom_customer.last_name = params[:custom_customer][:last_name]
    custom_customer.email_address = params[:custom_customer][:email_address]
    custom_customer.phone_number = params[:custom_customer][:phone_number]
    custom_customer.address = params[:custom_customer][:address]
    custom_customer.city = params[:custom_customer][:city]
    custom_customer.state = params[:custom_customer][:state]
    custom_customer.zip = params[:custom_customer][:zip]

    custom_customer.save

    @sale.add_customer(custom_customer.id)

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end


  # update Total For Line Items
  def update_line_item_totals(line_item)
    line_item.total_price = line_item.price * line_item.quantity
    line_item.save
  end


  def override_price
    @sale = Sale.find(params[:override_price][:sale_id])
    item = Item.where(:sku => params[:override_price][:line_item_sku] ).first
    line_item = LineItem.where(:sale_id => params[:override_price][:sale_id], :item_id => item.id).first
    line_item.price = params[:override_price][:price].gsub('$', '')
    line_item.save

    update_line_item_totals(line_item)
    update_totals
    total_price


    respond_to do |format|
      format.js { ajax_refresh }
    end
  end
  
def sale_discount
   
    @sale = Sale.find(params[:sale_discount][:sale_id])
    @sale.discount = params[:sale_discount][:discount]
    @sale.save

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end
#---------


  



  # Destroy Line Item
  def destroy_line_item
    set_sale
    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  # Update Sale Totals
  def update_totals

    tax_amount = get_tax_rate

    set_sale

    @sale.amount = 0.00

    for line_item in @sale.line_items
      @sale.amount += line_item.total_price
    end

    @sale.tax = @sale.amount * tax_amount
    total_amount = @sale.amount + (@sale.amount * tax_amount)

    if @sale.discount.blank?
      @sale.total_amount = total_amount
    else
      discount_amount = total_amount * @sale.discount
      @sale.total_amount = total_amount - discount_amount
    end

    
    @sale.save
  end


 def create_employee_association
    set_sale
    unless @sale.blank? || params[:employee].blank?
      e = Employee.find(params[:sale_comments][:employee]) 
      @sale.employee = e
      @sale.save
    end
    
  end


  def override_price
    @sale = Sale.find(params[:override_price][:id])
    item = Item.where(sku: params[:override_price][:line_item_sku]).first
    line_item = LineItem.where(sale_id: @sale.id, item_id: item.id).first
    line_item.price = params[:override_price][:price].gsub('$', '')

    update_line_item_totals(line_item)
    line_item.save
    update_totals


    respond_to do |format|
      format.js { ajax_refresh }
    end
  end





def add_comment

    set_sale


    if !params[:employee].blank?
    e = Employee.find_by(name: params[:employee]) 
         @sale.employee = e
         @sale.save


    end 

    if !params[:sale_comments][:comments].blank?

    @sale.comments = params[:sale_comments][:comments]
  if  @sale.save
  
   vergass
    
  end 
  else

    end 


    if !params[:name].blank?
     #@maa = Customer.where("(last_name || first_name ) LIKE :q", :q => params[:name]).first
    # @maa = Customer.find_by_last_name(params[:name]) 
     maa = Customer.find_by(first_name: params[:name])
         @sale.customer=  maa
         @sale.save
    end 
  
 
    if !params[:sale_comments]["start_date(1i)"].blank?

      @entre = DateTime.new(params[:sale_comments]["start_date(1i)"].to_i,params[:sale_comments]["start_date(2i)"].to_i,params[:sale_comments]["start_date(3i)"].to_i) 
      @sale.created_at =  @entre
      if @sale.save
        end 
     # somedate = DateTime.new(params["date1(1i)"].to_i, params["date1(2i)"].to_i, params["date1(3i)"].to_i,params["date1(4i)"].to_i,params["date1(5i)"].to_i)
    end 
   

   

    respond_to do |format|
      format.js { ajax_refresh }
     
    end
  end



  




    def ajax_refresh
      return render(:file => 'sales/ajax_reload.js.erb')
    end

    def  dame 
      return render(:file => 'sales/hola.js')
    end



    # Use callbacks to share common setup or constraints between actions.
    def set_sale
    if @sale.blank?
        if params[:sale_id].blank?
          if params[:search].blank?
            @sale = Sale.find(params[:id])
          else
            @sale = Sale.find(params[:search][:sale_id])
          end
        else 
          @sale = Sale.find(params[:sale_id])
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:amount, :tax, :discount, :total_amount, :tax_paid, :amount_paid, :paid, :payment_type_id, :customer_id, :comments, :line_items_attributes, :items_attributes, :employye_id,:employee,:item_category,:data,"date1(1i)","date1(2i)","date1(3i)","date1(4i)","date1(5i)",:emplo)
    end

    def populate_items
      @available_items = Item.all(:conditions => ['published', true], :limit => 5)
    end

    def populate_customers
      @available_customers = Customer.all(:conditions => ['published', true], :limit => 5)
    end

    def populate_employee
      @available_employee = Employee.all
    end



   # def remove_item_from_stock(item_id, quantity)
   #  item = Item.find(item_id)
   #   item.stock_amount = item.stock_amount - quantity
   #   item.amount_sold += quantity
   #   item.save
   # end


    def remove_item_from_stock(item_id, quantity)
      item = Item.find(item_id)
       s= item.stocks
       k = s.where(store_configuration_id:current_user.store_configuration.id).last
      if k ==nil
      e= Stock.new
      e.item = item
      e.quantity =0 
      e.rank  = 0 
      e.store_configuration =current_user.store_configuration
      e.token =  loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Stock.exists?(token: random_token)
       end
       e.save 
      item.stock_amount = item.stock_amount - quantity
      item.amount_sold += quantity
      item.save
      else 
      s= item.stocks
      k = s.where(store_configuration_id:current_user.store_configuration.id).last
      k.quantity = k.quantity - quantity         
      k.save
      end 
    end




    def add_item_from_stock(item_id,quantity)
      item = Item.find(item_id)
       s= item.stocks
       k = s.where(store_configuration_id:current_user.store_configuration.id).last
      if k ==nil

      e= Stock.new
      e.item = item
      e.quantity =0 
      e.rank  = 0 
      e.store_configuration =current_user.store_configuration
      e.token =  loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Stock.exists?(token: random_token)
       end

       e.save 
      item.stock_amount = item.stock_amount + quantity
      item.amount_sold += quantity
      item.save
      else 
      
      s= item.stocks
      k = s.where(store_configuration_id:current_user.store_configuration.id).last
      k.quantity = k.quantity + quantity         
      k.save
      end 

    end 


    def canceled_sales 
    set_sale
    populate_items
    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    @sale.estatus = nil
    @sale.save
    line_item.each do |variable|
    add_item_from_stock(line_item.item_id, line_item.uantity)
     end

     respond_to do |format|
      format.js { ajax_refresh }
     end

    end 


   def return_item_to_stock(item_id, quantity)
   # item = Item.find(item_id)
    #  s= item.stocks
     # k = s.where(store_configuration_id:current_user.store_configuration.id).last
     # k.quantity = k.quantity + quantity
     # k.save
     item = Item.find(item_id)
     item.stock_amount = item.stock_amount + quantity
     item.save
    end

    def get_tax_rate
      if @configurations.tax_rate.blank?
        return 0.00
      else
        return @configurations.tax_rate.to_f * 0.01
      end
    end

end
