class UnchainedCategory < ActiveRecord::Base
		validates_presence_of :name
		has_many :unchained_category_maps
		has_many :parent_relation,:foreign_key => "category_id",:class_name => "UnchainedCommerce::UnchainedCategoryMap"
		has_many :child_relations,:foreign_key => "parent_category_id",:class_name => "UnchainedCommerce::UnchainedCategoryMap"
		has_many :parent_attribute,:through => :parent_relation
		has_many :children,:through => :child_relations, :source => :unchained_category
end
