ActiveAdmin.register StoreConfiguration do
    menu label: "Tiendas "

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model,:store_name, :store_description, :email_address, :phone_number, :website_url, :address, :city, :state, :zip, :currency, :tax_rate, :name
#
# or
#
# permit_params do
  permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permi
index :title => 'Tienda ' do
    selectable_column
      column "id",:id
      column "Nombre ", :name
      column "Tienda Descripción:", :store_description
    	column "Correo electronico",:email_address
    	column "Numero de telefono",:phone_number
    	column "Url del sitio web",:website_url
    	column "Direccion",:address
    	column "Ciudad",:city
    	column "Estado",:state
    	column "Numero",:zip
      actions
  end

  filter :zip, label: 'Tienda'



   show :title => proc{|store_configuration| store_configuration.store_name } do
    panel "Datos" do
     attributes_table_for store_configuration do
      row('Nombre de la tienda') { |b|  b.store_name }
      row('Tienda Descripción') { |b|  b.store_description }
      row('Correo electronico') { |b|  b.email_address}
      row('Numero de telefono') { |b| b.phone_number}
      row('Url del sitio web ') { |b|   b.website_url? }
      row('Direccion') { |b|  b.address }
      row('Ciudad') { |b|  b.city }
      row('Estado') { |b|  b.state}
      row('Numero') { |b| b.zip}
    end
  end
  active_admin_comments
end


       form do |f|
      inputs 'Detalles' do
      input :name  , label:"Nombre "
      input :store_description, label:"Tienda Descripción"
      input :email_address, label: "Correo electronico  de Tienda"
      input :phone_number , label:"Numero de telefono" 
      input :website_url, label:"Url del sitio web"
      input :address , label:"Direccion"
      input :city , label: " Ciudad"
      input :zip , label: "Numero"



    
      f.actions
      end


     end 




end
