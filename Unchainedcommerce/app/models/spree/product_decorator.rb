module Spree
  Product.class_eval do
    def product_attribution
      attributes = AttributeMap.joins("INNER JOIN unchained_commerce_product_attributes on unchained_commerce_attribute_maps.id = unchained_commerce_product_attributes.attribute_map_id and unchained_commerce_product_attributes.product_id = #{self.id}")
      root_attributes =  get_attributes(nil,attributes)
      attribute = []
      child_attribute_hash = {}
      for root_attribute in root_attributes
        root_attribute_name = Attribution.find(root_attribute.attribution_id).name
        root_hash = {root_attribute_name =>{:value=>ProductAttribute.where(:attribute_map_id=>root_attribute.id).first.value,:children=>{}}}
        root_child_hash = {}
        root_hash[root_attribute_name][:children] = get_attributes(root_attribute, attributes, root_child_hash)
        attribute << root_hash
      end
      return attribute
    end


    def get_attributes(node,attribute_hash,child_hash = nil)
      if node.nil?=
        return attribute_hash.where(:parent_attribute_id=>node)
      else
        child_nodes = attribute_hash.where(:parent_attribute_id=>node.attribution_id)
        name = Attribution.find(node.attribution_id).name

        if child_nodes.count == 0
          return {}
        else
          for child in child_nodes
            childs_child={}
            child_name =Attribution.find(child.attribution_id).name
            child_hash.merge!({ child_name =>{:value=> ProductAttribute.where(:attribute_map_id=>child.id,:product_id=> self.id).first.value,:children=>{}}})
            child_hash[child_name][:children].merge!(get_attributes(child,attribute_hash,childs_child))
          end
          return child_hash
        end
      end
    end
  end
end

