class Addsaleidsale < ActiveRecord::Migration
  def change
  		add_column    :users , :store_configuration_id, :integer
  end
end
