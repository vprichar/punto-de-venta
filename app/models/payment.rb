class Payment < ActiveRecord::Base
	belongs_to :sale

	def amount_after_change
	
         if (!self.sale.total_amount == nil || self.amount == nil   )
         value = self.sale.total_amount - self.amount
     end 
  

		
         value = 0 
		

		if value >= 0
			return self.amount
		else
			return self.sale.total_amount
		end
				
	end
end
