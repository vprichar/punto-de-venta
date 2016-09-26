class PaymentsController < ApplicationController

	def make_payment
		@sale = Sale.find(params[:payments][:sale_id])
		payment = Payment.create(:payment_type => params[:payments][:payment_type], :amount => params[:payments][:amount], :sale_id => params[:payments][:sale_id])

    @sale.estatus = 1
    @sale.save
  	respond_to do |format|
      format.js
    end
  end
  
  private
  def payment_params
    params.require(:payment).permit(:payment_type, :amount, :sale_id)
  end
end
