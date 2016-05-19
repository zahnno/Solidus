class ProductAttribute < ActiveRecord::Base
	belongs_to :product
	belongs_to :attribute_map
end

