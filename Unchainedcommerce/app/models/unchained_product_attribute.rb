class UnchainedProductAttribute < ActiveRecord::Base
	belongs_to :product
	belongs_to :unchained_attribute_map
end