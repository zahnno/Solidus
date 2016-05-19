class AppProductCodeToProducts < ActiveRecord::Migration
  def change
  	add_column :spree_products, :code, :string
  end
end