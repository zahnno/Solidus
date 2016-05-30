class UnchainedAttribution < ActiveRecord::Base
		validates_presence_of :name
		has_many :unchained_attribute_maps
		has_many :parent_relation,:foreign_key => "attribute_id",:class_name => "UnchainedCommerce::UnchainedAttributeMap"
		has_many :child_relations,:foreign_key => "parent_attribute_id",:class_name => "UnchainedCommerce::UnchainedAttributeMap"
		has_many :parent_attribute,:through => :parent_relation
		has_many :children,:through => :child_relations, :source => :unchained_attribution
end
