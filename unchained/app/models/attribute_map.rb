module UnchainedCommerce
  class AttributeMap < ActiveRecord::Base
	belongs_to :parent_attribute, :class_name => "UnchainedCommerce::Attribution", :inverse_of => :parent_relation
	belongs_to :attribution, :class_name => "UnchainedCommerce::Attribution", :inverse_of => :child_relations
	has_many :product_attributes
  end
end