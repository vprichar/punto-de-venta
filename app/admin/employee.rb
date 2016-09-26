ActiveAdmin.register Employee do
	menu label: "vendedores "
  
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :list, :of, :attributes, :on, :model , :name, :rfc ,:address ,:phone, :email,:published


#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


 index :title => 'vendedores ' do
    selectable_column
    id_column
    column "Nombre" ,:name
    column "RFC",:rfc
    column "Direcion ",:address
    column "Cel ",:phone
    column "Correo",:email
     column "Estado",:published

    actions
  end

    filter :published, label: 'vendedores activos'
    filter :rfc , label: 'vendedores activos'
    filter :phone ,label: 'Telefono'
    filter :name ,label: 'Nombre'


  show do
    panel "Datos" do
     attributes_table_for employee do
      row('Nombre') { |b|  b.name }
      row('Correo') { |b|  b.email }
      row('Cel') { |b|  b.phone }
      row('RfC ') { |b| b.rfc  }
      row('Estados ') { |b| status_tag  b.published? }
    end


      
    end
    active_admin_comments
  end



  	    


end
