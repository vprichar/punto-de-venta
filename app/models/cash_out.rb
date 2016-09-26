class CashOut < ActiveRecord::Base
	has_many :sales
	belongs_to :user
end
