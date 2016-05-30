class CreateAttributeMaps < ActiveRecord::Migration
  def change
    create_table :attribute_maps do |t|
    	t.integer :attribution_id
    	t.integer :parent_attribute_id
    end
        add_index :attribute_maps, :attribution_id
    	add_index :attribute_maps, :parent_attribute_id
  end
end