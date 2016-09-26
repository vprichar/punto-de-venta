class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :username, :presence => true, :uniqueness => true
  #validates :store_configuration ,:presence => true 

  has_many :sales
  has_many :cash_outs
  has_many :purchaseorder 
  belongs_to :store_configuration
  

end
