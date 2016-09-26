ActiveAdmin.register User do
  menu label: "cajeros"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model,:username,:email,:can_update_items,:can_update_users,:can_update_configuration,:can_view_reports,:password,:password_confirmation,:store_configuration_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

 index :title => 'Cajeros ' do
    selectable_column
    column "Nombre", :username
    column "Correo",:email

    column "Sucursal" do |m|
       usr = StoreConfiguration.find_by(id: m.store_configuration_id)
           if (usr  != nil)
               usr.name
          else
          "no tiene tienda"
           status_tag( "error " , :false) 
    end 
  end

    

   # column :remember_created_at
   # column :sign_in_count
   # column :current_sign_in_at
   # column  :last_sign_in_at
   # column  :current_sign_in_ip
   # column  :last_sign_in_ip
    column  "Puede actualizar Usuarios",:can_update_users
    column  "Puede actualizar productos",:can_update_items
   # column  "Puede actualizar configuración",:can_update_configuration
   # column   "Puede ver informes",:can_view_reports
    column  "Puede actualizar Descuento de venta",:can_update_sale_discount
    
       actions
  end


    filter :username, label: 'Nombres'
    filter :email , label: 'Email'


  

      form do |f|
      inputs 'Detalles' do
      input :store_configuration, label: "Tienda"
      input :username, label: "Nombre"
      input :email, label:"Email"
      input :password,label:"contraseña"
      input :password_confirmation,label: "confirmacion contraseña"
      input :can_update_users ,label: "actualizar usuarios"
      input :can_update_items , label:"actualizar productos"
      input   :can_update_sale_discount, label:"Descuento"
      #f.input :store_configuration,  :as => : :datalist,      :collection => StoreConfiguration.all
        
      f.actions
      end

     end 


show do
    panel "Datos" do
     attributes_table_for user do
      row('Nombre') { |b|  b.username }
      row('Correo') { |b|  b.email }
      row('actualizar usuarios')   { |b| status_tag  b.can_update_users?}
      row('actualizar productos ') { |b| status_tag  b.can_update_items? }
      row('actualizar  Descuento') { |b| status_tag  b.can_update_sale_discount? }
      row('Tienda') { |b| status_tag  b.store_configuration.name }

      end


      
    end
    active_admin_comments
  end







end
