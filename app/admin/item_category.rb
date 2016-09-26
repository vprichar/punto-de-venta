ActiveAdmin.register ItemCategory do
permit_params :list, :of, :attributes, :on,:name, :description


 


menu label: "Marcas"



    index :title => 'Marcas ' do
    selectable_column
     column "ID ",:id
     column "Nombre",:name
     column "Descripsion",:description

      actions
  end

  show do
    panel "Datos" do
     attributes_table_for ItemCategory  do
      row('Nombre') { |b|  b.name }
     # row('hola') { |b|  b.description }
 
    end
  end
 
end








   end 

