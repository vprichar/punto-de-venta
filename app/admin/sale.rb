ActiveAdmin.register Sale do
  menu label: "ventas"


 permit_params :list, :of, :attributes, :on, :model,:employye,:amount,:customer,:created_at
 #actions :all, :except => [:destroy]
 #actions :all, :except => [:edit]




 index :title => 'ventas ' do
    selectable_column
    id_column 
    column ("cantidad"),:cut
    column ("cantidad total "),:total_amount
    column ("cantidad restante"),:remaining_amount
    column ("descuento"),:discount
    column ("cliente"), :customer, :sortable => :customer_id
    column ("Empledooooo"), :employye, :sortable => :employee_id
    column("Pagado")   {|order| status_tag(order.pagado)}
    column ("Comentario"), :comments
    column("Estado")   {|order| status_tag(order.estatus)}

    column :name

    actions defaults: true  do |post|
      
      link_to('Cancelar ', validate_admin_sale_path(post.id), class: "member_link")
    
    end
  end

  member_action :validate, method: :get do
      tienda = Sale.find(params[:id])
   
      lineitems = tienda.line_items
       if tienda.estatus !=nil 
       lineitems.each do |li|
        e = Stock.where(item_id: li.item_id,  store_configuration_id: tienda.store_configuration_id).last
        e.quantity += li.quantity
        e.save     
       end
        tienda.estatus = nil  ; 
        tienda.comments = "Esta venta fue cancelada   "
        tienda.save 
        redirect_to collection_path, notice: "La venta fue candelada   "
      else 
         redirect_to collection_path, alert: "Error esta venta ya fue cancelada  "

     end 

  end




  filter :amount
  filter :id 
  filter :created_at


  form do |f|
    f.inputs "Detalle de venta" do
      f.input :amount 
      f.input :customer 
      f.input :comments
      f.input :created_at
    end
    f.actions
   
  end



  index download_links: false
  index download_links: [:pdf]
  index download_links: proc{ current_user.can_view_download_links? }





   show :id => :id 

show do
    panel "Productos" do
      table_for(sale.line_items) do |t|
        t.column("Product") {|item| auto_link item.item }
        t.column("cantidad"){|item| auto_link item.quantity }
        t.column("Price")   {|item| number_to_currency item.price }
        t.column("Price")   {|item| number_to_currency item.price }
        tr :class => "odd" do td "Total:", :style => "text-align: right;"
          td number_to_currency(sale.total_amount)
        end
      end
    end

     panel "pago" do
      table_for(sale.payments) do |t|
        t.column("tipo de pago") {|item| auto_link  item.payment_type }
        t.column("Fecha de pago") {|item| item.created_at } 
      end
    end
     panel "venta" do
      table_for(sale) do |t|
       t.column("total") {|item|  item.total_amount }
       t.column("Fecha de venta") {|item| item.created_at } 
       t.column("cambio") {|item| item.remaining_amount } 
       

      end
      end 
  end

  sidebar :informacion_cliente, :only => :show do
   attributes_table_for  sale.customer do
    if (sale.customer  != nil )
    row("+") { auto_link( sale.customer, 'mas informacion de '.to_s + sale.customer.first_name.to_s )  }    
    row("Nombre") {  sale.customer.first_name}   
    row("Cel") {  sale.customer.phone_number} 
    row("RFC") {  sale.customer.zip}     
  else
    "No tiene clientes "
  end 
  end 
  end


   sidebar :Informacion_de_vendedor, :only => :show do
     if (sale.employee  != nil )
      table_for(sale.employee) do |t|
        t.column("tipo de pago") {|item| auto_link  sale.employee.name }
      end 
     else
      "No tiene vendedor "
     end

  end

end




