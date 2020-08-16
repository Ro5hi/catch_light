class Createphotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.integer :user_id 
      t.string :file
      t.string :url
    end 
  end 
end
