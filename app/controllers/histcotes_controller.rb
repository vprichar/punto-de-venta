class HistcotesController < ApplicationController

  def index
  	@histcotesController = CashOut.all
  end

   def show
     set_corte
      cashOut = CashOut.find(@histcotesController.id)
    @articulos  = cashOut.sales
    @total = cashOut.total_price
    @numero = @articulos.count
    @empleados =@articulos.group(:employee_id).sum(:total_amount)

  end

  def set_corte
      	@histcotesController = CashOut.find(params[:id])
     	
    end



end
