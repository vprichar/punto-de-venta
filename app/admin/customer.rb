ActiveAdmin.register Customer do
menu label: "Clientes"
  batch_action :destroy, false
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  
  permit_params :list,:last_name ,:email_address , :phone_number, :address,:city, :state, :zip, :published
  index :title => 'Clientes ' do
    selectable_column
    id_column
    column "Coreo" ,:email_address
    column "Nombre",:last_name
    column "Cel",:phone_number
    column "RFC ",:zip
    column "Empleado activos",:published
    actions
  end

    filter :published, label: 'Empleado activos'
    filter :zip , label: 'Codigo de empleado'
    filter :phone_number ,label: 'Telefono'
    filter :last_name ,label: 'Nombre'




    show :zip => :zip

   


  form do |f|
    inputs 'Deraller' do
      input :email_address, label: "correo"
      input :last_name, label:"Nombre"
      input :phone_number ,label: "Cel"
      input :zip , label:"RFC"
      input :published, label:"Empleado activos"
    
    end
    f.actions
    
  end

show do
    panel "Datos" do
     attributes_table_for customer do
      row('Nombre') { |b|  b.last_name }
      row('Correo') { |b|  b.email_address }
      row('Cel') { |b|  b.phone_number }
      row('Codigo ') { |b| b.zip  }
      row('Estados ') { |b| status_tag  b.published? }
    end


      
    end
    active_admin_comments
  end


  


  






end
