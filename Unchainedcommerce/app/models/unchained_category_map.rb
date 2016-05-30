class UnchainedCategoryMap < ActiveRecord::Base
	belongs_to :parent_category, :class_name => "UnchainedCommerce::UnchainedCategory", :inverse_of => :parent_relation
	belongs_to :category, :class_name => "UnchainedCommerce::UnchainedCategory", :inverse_of => :child_relations
end
