class CreateAttributeMaps < ActiveRecord::Migration
  def change
    create_table :unchained_attribute_maps do |t|
    	t.integer :attribution_id
    	t.integer :parent_attribute_id
    end
        add_index :unchained_attribute_maps, :attribution_id
    	add_index :unchained_attribute_maps, :parent_attribute_id
  end
end