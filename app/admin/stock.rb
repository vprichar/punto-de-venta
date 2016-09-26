ActiveAdmin.register Stock do


menu label: "Stoct  tiendas "
config.batch_actions = true

 
 
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
 #permit_params :list, :of, :attributes, :on, :model

 permit_params :quantity,:rank,:item_id,:store_configuration_id,:stock_amount,:created_at,:updated_at,:token


    #filter :store_configuration, :collection => proc { StoreConfiguration.all }, :as => :select
    filter :store_configuration, as: :check_boxes
    filter :item_id, :as => :string

    #filter :item, :collection => proc {Item.all}, :as => :select ,label: 'Articulos'
    # filter :author, label: 'Something else'



    before_create do |product|
    product.token =    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Stock.exists?(token: random_token)
       end
    end



  #filter :store_configuration, as: :select, collection: StoreConfiguration.all, label: 'Organization'
  index :title => 'Stoct  tiendas' do
    selectable_column
    column :token
    column "Producto" do |t|
    
      tem =Item.find_by(id: t.item_id)
      tem.name
     end 
    column "Producto" do |t|
     tem =Item.find_by(id: t.item_id)
     tem.sku
    end 
    column ("cantidad"),:quantity
    column("por terminar") do |stock| 
      stock.rank < stock.quantity ? status_tag( "Estable " , :ok ) : status_tag( "Limite" )
    end
    column "Sucursal" do |m|
       usr = StoreConfiguration.find_by(id: m.store_configuration_id)
           if (usr  != nil)
               usr.name
          else
          "no tiene tienda"
           status_tag( "error " , :false) 
    end 
  end
     actions
      end
   


 sidebar :Información_de_ubicación  , :only => :show do
    attributes_table_for  stock.store_configuration do    
    row("Nombre: "){stock.store_configuration.name }   
    row("Tel: "){stock.store_configuration.phone_number} 
    row("Dirección: ") {stock.store_configuration.address}  
    
  end 
  
 
    

  end 

   

  csv do
    column (:token ) { |post| post.token }
    column "Producto" do |t|
  tem =Item.find_by(id: t.item_id)
     tem.name.to_s + "......" +tem.description
    end 
    column "sku" do |t|
    tem =Item.find_by(sku:  t.item.sku)
    tem.sku
    end 
    column "cantidad" do |t|
    t.quantity
    end 
     column "rank" do |t|
    t.rank
    end 
    column "tienda" do |m|
    usr = StoreConfiguration.find_by(id: m.store_configuration_id)
     if (usr  != nil)
        usr.name
         else
      "no tiene tienda"
        end 
    end
 end


 active_admin_importable do |model, hash|
      stoc = Stock.find_by_token(hash[:token])
      if ( stoc == nil)
      model.create(
      :item   => Item.find_by_sku(hash[:sku]),
      :quantity  =>  hash[:cantidad],
      :rank => hash[:rango],
      :store_configuration => StoreConfiguration.find_by(name: hash[:tienda]),
      :token =>  loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Stock.exists?(token: random_token)
       end
       )  
    else 
      if (hash[:tienda] == nil)
       stoc.quantity = 800
       stoc.store_configuration = nil
       stoc.save
     else 
     
      stoc.quantity = hash[:cantidad]
     
      stoc.rank =hash[:rango]
      if  stoc.rank== nil 
         stoc.rank = 0
      end 




      stoc.store_configuration = StoreConfiguration.find_by(name: hash[:tienda])

       stoc.save
     end 


      end
   end



      form do |f|
      inputs 'Detalles' do
      input :store_configuration , label:"Tienda"
      input :item, label:"Producto"
      input :quantity, label: "cantidad"
      input :rank , label:"Rango" 
      f.actions
      end
     end 


controller do
    def create
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end

    def update
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end
  end


   csv do
   column (:item_id) { |post| Item.find_by(id:post.id).sku}
   column (:tem) { |post| Item.find_by(id:post.id).nombre_completo}
   column (:cantidad) { |post| post.quantity}
   column (:rango) { |post| post.rank} 
   column (:tienda) { |post|  StoreConfiguration.find(post.store_configuration).name }
   column :token
   end 



  



  



end


