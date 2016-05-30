class CreateCategory < ActiveRecord::Migration
  def change
    create_table :unchained_categories do |t|
    	t.string :name
    	t.timestamps null: false
    end

    create_table :unchained_category_maps do |t|
    	t.integer :category_id
    	t.integer :parent_category_id
    end
        add_index :unchained_category_maps, :category_id
    	add_index :unchained_category_maps, :parent_category_id
  end
end
