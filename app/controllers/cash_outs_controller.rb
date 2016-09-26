
class CashOutsController < ApplicationController
	  helper_method :test
 @articulos 
	def index
    @cash_outs = CashOut.paginate(:page => params[:page], :per_page => 20)
    @articulos  = Sale.where( :user_id => current_user.id  ).where("created_at >= ?", Time.zone.now.beginning_of_day).where( :cut => nil ).where.not(estatus:nil )
    @total = @articulos.sum(:total_amount) 
    @numero = @articulos.count
    @empleados =@articulos.group(:employee_id).sum(:total_amount)
	end


   def  cortes 
  # @articulos.group(:customer_id).sum(:total_amount) 
 @articulos  = Sale.where( :user_id => current_user.id  ).where("created_at >= ?", Time.zone.now.beginning_of_day).where( :cut => nil ).where.not(estatus:nil )
  respond_to do |format|
  format.json { render :json => @articulos }
   end
   end 

	def show
     @cash_outs = CashOut.all
        @cash_outs .each do |uno|
      uno.destroy
    end 

	end

def dame
   @articulos = Sale.where( :user_id => current_user.id ).where("created_at >= ?", Time.zone.now.beginning_of_day).where( :cut => nil)
   @total  = @articulos.sum(:total_amount) 
   @numero =   @articulos.count
   @cash_out = CashOut.new(:user_id => current_user.id ,:sales  =>  @articulos,:total_price => @total , :total_sales =>  @numero)

     @articulos.each do |baja|
      baja.cut= true;
      baja.save

     end 
    
  
    respond_to do |format|
        @cash_out.save
        format.html { redirect_to cash_outs_url }
        format.json { render action: 'show', status: :created, location: @item }
    end
  end


	def test (param)
		@line_items = LineItem.where("sale_id = ?", param)
	end

	def change_status
		@cash_out = CashOut.create()
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cash_out
      @cash_out = CashOut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:cash_out).permit(:user, :user_id, :total_price, :total_sales,:sale)
    end
end