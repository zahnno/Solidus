class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :unchained_product_attributes do |t|
			t.integer :product_id
			t.integer :attribute_map_id
			t.string  :value
      t.timestamps null: false
    end
      add_index :unchained_product_attributes, :product_id  
  end
end
