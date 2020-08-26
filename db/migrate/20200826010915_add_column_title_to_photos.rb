class AddColumnTitleToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :title, :string 
  end
end
