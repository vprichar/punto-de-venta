  class CreateRetails < ActiveRecord::Migration
  def change
    create_table :retails do |t|
      t.string :name
      t.string :address
      t.integer :phone
      t.boolean :status
      t.integer :published

      t.timestamps
    end
  end
end
