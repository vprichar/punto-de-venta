class Sale < ActiveRecord::Base
	belongs_to :customer
	belongs_to :employee
	belongs_to :user
	belongs_to :cash_out
	belongs_to :store_configuration
	belongs_to :stocks

	
	

	has_many :line_items, dependent: :destroy
	has_many :items, :through => :line_items
	has_many :connections, :through => :customer
	has_many :payments, dependent: :destroy

	accepts_nested_attributes_for :line_items, :allow_destroy => true
	accepts_nested_attributes_for :items, :allow_destroy => true
	accepts_nested_attributes_for :payments, :allow_destroy => true

	def remaining_balance
		if self.total_amount.blank?
			balance = 0.00
		else
			balance = self.total_amount - paid_total
		end

		if balance < 0
			return 0
		else
			return balance.round(2)
		end
	end



	def get_discounted_amount
		self.total_amount * self.discount
	end
	


	def paid_total
		paid_total = 0.00
		unless self.payments.blank?
			for payment in self.payments
				paid_total += payment.amount.blank? ? 0.00 : payment.amount
			end
		end
		return paid_total
	end
	




	#def paid_total
	#		paid_total = 0.00
	#		unless self.payments.blank?
	#			for payment in self.payments
	#				paid_total += payment.amount.blank? ? 0.00 : payment.amount
	#			end
	#		end
	#	if self.total_amount.blank?
	#		return 0.00
	#	else
	#		
	#		if paid_total > self.total_amount
	#			return self.total_amount
	#		else
	#			return paid_total
	#		end
	#	end
	#end



	def change_due
		if self.total_amount.blank?
			return 0.00
		else
			if paid_total > self.total_amount
				return paid_total - self.total_amount
			else
				return 0.00
			end
		end
	end

	def pagado
		if self.total_amount.blank?
			balance = 0.00
		else
			balance = self.total_amount - paid_total
		end

		if balance < 0
			return false

		else
			return  true
		end
	end

	def add_customer(customer_id)
		self.customer_id = customer_id
    self.save
	end

	def add_employee(employee_id)
		self.employye_id = employee_id
    self.save
	end

end
