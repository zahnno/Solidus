class CreateAttributions < ActiveRecord::Migration
  def change
    create_table :unchained_attributions do |t|
    	t.string :name
    	t.string :attribute_code
      t.timestamps null: false
    end
  end
end