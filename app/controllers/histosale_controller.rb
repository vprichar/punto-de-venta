class HistosaleController < ApplicationController
  # GET /items.json
  def index
   # @sales = Sale.paginate(:page => params[:page], :per_page => 20)
     @sales = Sale.where( :user_id => current_user.id  )  .paginate(:page => params[:page], :per_page => 20)
 end 
end
