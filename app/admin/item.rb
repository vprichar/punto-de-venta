ActiveAdmin.register Item do
menu label: "Productos"
permit_params :list, :of, :attributes, :on, :model,:id,:sku,:name,:description,:price,:stock_amount,:cost_price,:published,:model,:item_category_id


config.batch_actions = true
config.per_page = 100

batch_action :barremos do |ids|
     Item.find(ids).each do |post|
       
          post.description = post.description.to_s+ " "
           post.save


    end
    redirect_to collection_path, alert: "The posts have been flagged." + ids.count.to_s
  end



    index :title => 'Productos' do
    selectable_column


     column "id",:id
     column  "Sku",:sku
     column "Nombre",:name
     column "Descripción",:description
     column "Precio",:price
     column "Stock",:stock_amount
     column "Costo",:amount_sold
     column "Costo P",:cost_price
     column "Estado",:published
     column "Modelo",:model    
     column "Marca ",:item_category
    

  

     actions
  end



 
    filter :sku, label: 'Codigo'
    filter :name , label: 'Nombre'


    filter :price ,label: 'Precio'
    
    filter :model ,label: 'Modelo'

    filter :description, label: 'Descripción'
    filter :description_blank,   :as => :boolean  , label:'Descripción es nula '


   show :sku => :sku

  sidebar :informacion do

   end

    sidebar :ventas_por_producto, :only => :show do
    attributes_table_for resource do
      row("ventas totales"){ number_to_currency LineItem.where(:item_id => resource.id).sum(:price) }
       row("ventas totales"){  LineItem.where(:item_id => resource.id).count(:price) }
    end
  end


  show do
    panel "Datos" do
     attributes_table_for item do
      row('Nombre ') { |b|  b.name }
      row('Sku') { |b|  b.sku }
      row('Precio') { |b|  b.price }
      row('Stock ') { |b| b.stock_amount }
      row('Estados') { |b| status_tag  b.published? }
      row('Marca') { |b|  b.item_category }
    end
    panel "stock" do
      table_for(item.stocks) do |t|
        t.column("cantidad") {|item| auto_link  item.quantity }
        t.column("Tienda") {|item| item.store_configuration.name} 
        t.column("Tel") {|item| item.store_configuration.phone_number} 

        #t.column ("Fecha de venta"), :created_at
      end
      end
  end
  active_admin_comments
end

 index as: :grid do |post|
    resource_selection_cell post
    h2 auto_link post
  end

  # Index as Blog requires nothing special

  # Index as Block
  index as: :block do |post|
    div for: post do
      resource_selection_cell post
    end
  end






  csv do
  column :id 
  column :sku
  column :name
  column :price
  column :stock_amount
  column :description
  column :cost_price
  column :model
  column (:item_category ) { |post| post.item_category .id }
  end


active_admin_importable do |model, hash|
      store = Item.find_by_sku(hash[:sku])
      if (store == nil)
      model.create(
      :sku   => hash[:sku],
      :name  => hash[:name],
      :price  => hash[:price],
      :stock_amount       => hash[:stock_amount],
      :description       => hash[:description],
      :cost_price => hash[:cost_price],
      :model  => hash[:model],
      :item_category => ItemCategory.find_by(id: hash[:item_category])
     )  
    else 

      store.update_attributes({
       :sku => hash[:sku],
       :name => hash[:name],
       :price => hash[:price],
       :stock_amount  => hash[:stock_amount],
       :description  => hash[:description],
       :cost_price => hash[:cost_price],
       :model => hash[:model],
       :item_category => ItemCategory.find_by(id: hash[:item_category])
      });
      store.save
      end
   end

  


  

end
