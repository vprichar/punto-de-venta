ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation , :username
  batch_action :destroy, false
  menu label: "Adminitradores de "

  index :title => 'Adminitradores ' do

     
    selectable_column
    id_column
    column "Coreo" ,:email
    column "Nombre",:username
    column "Ultima  conexión",:current_sign_in_at
    column "Código ",:sign_in_count
    column "Creado en ",:created_at
    actions
  end

  filter :email
  filter :username


  form do |f|
    f.inputs "Detalles de usuario" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end




end
