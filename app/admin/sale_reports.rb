ActiveAdmin.register SaleReports do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end



 permit_params :name ,:store_configuration_id, :initial_date, :final_date, :total_sales_number, :total_cash, :created_at,:updated_at

filter :name, label: 'Nombre'

form do |f|
       f.inputs "hola" do
       f.input :name , label:"Nombre"
       f.input :store_configuration_id , :label => ' tienda ', :as => :select, :collection => StoreConfiguration.all 
       f.input  :initial_date, :as => :datepicker , :label => 'Fecha inicial  '
       f.input  :final_date, :as => :datepicker  ,:label => 'Fecha  final '
    end
    f.actions
   
  end

#detalle


  # ventas = Sale.find(:all,:conditions => [ " created_at between ? and ? ",repo.initial_date,repo.final_date ])


   show do
   repo = SaleReports.find(params[:id])
   ventas = Sale.where(:created_at => (repo.initial_date.beginning_of_day..repo.final_date.end_of_day)).where(:store_configuration_id => repo.store_configuration_id)

  empleado = ventas.group(:employee_id).sum(:total_amount)
  empleadocu = ventas.group(:employee_id).count
  
  ventasdia = ventas.group( 'date(created_at)').count



  suma =ventas.sum(&:total_amount)
    panel "Productos listados " do
       
        table_for(ventas) do |t|
        t.column("id") {|item| auto_link item.id }
        t.column("cantidad") {|item|  item.amount }
        t.column("cambio") {|item| item.remaining_amount } 
        t.column("total_amount") {|item| item.total_amount} 
        tr :class => "oddd" do td td td   "Total:", :style => "text-align: right;"
          td number_to_currency(suma)
      end 
        end
      
      end
   

     panel "ventas por empleado---- " do
       table_for(empleado.each) do |t|
            t.column("Nombre") {|item|  
            if item[0] != nil 
             Employee.find_by(id:item[0]).name
            else 
              "tienda "
            end }
            t.column("Total vendido por  empleado ") {|item| "$"+item[1].to_s }
        end 


table_for(empleadocu.each) do |t|
          t.column("Nombre") {|item|  
            if item[0] != nil 
              Employee.find_by(id:item[0]).name
            else 
              "tienda "
            end }
              t.column("ventas por empleado") {|item|  item[1] }
        end 
    end

     panel " ventas por dia " do
      table_for(ventasdia.each) do |t|
          t.column("Nombre") {|item|  item[0]  }
          t.column("Total vendido por  empleado ") {|item|  item[1] }
      end 
      end 
   panel "no es " do

   end 
  end











  controller do
    def create
      super do |format|
       # redirect_to collection_url and return if resource.valid?
      end
    end

    def update
      super do |format|
       #redirect_to collection_url and return if resource.valid?
      end
    end
  end


end
