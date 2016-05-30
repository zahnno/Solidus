class UnchainedAttributeMap < ActiveRecord::Base
	belongs_to :parent_category, :class_name => "UnchainedCommerce::UnchainedAttribution", :inverse_of => :parent_relation
	belongs_to :category, :class_name => "UnchainedCommerce::UnchainedAttribution", :inverse_of => :child_relations
	has_many :unchained_product_attributes
end
