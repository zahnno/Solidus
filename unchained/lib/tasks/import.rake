require 'csv'
require 'open-uri'

namespace :import do
  desc "Import products from csv"
  # RUN THIS TASK FIRST
  task :products => :environment do
    # Clear the product and Attribute tables
    Spree::Product.destroy_all
    UnchainedCommerce::ProductAttribute.destroy_all
    Spree::Sample.load_sample("shipping_categories")
    products_path = Rails.root.join('db','import','product_list.csv')
    shipping_category = Spree::ShippingCategory.find_by_name!("Default")

    default_attrs = {
      shipping_category: shipping_category,
      available_on: Time.zone.now,
      promotionable: true,
      price: 0.0
    }

    def attribute_structure(attribute_object,product_id,parent_attribute=nil)
      attribute = UnchainedCommerce::Attribution.find_by_attribute_code(attribute_object)
      attribute_map = UnchainedCommerce::AttributeMap.where(:attribution_id=>attribute.id, :parent_attribute_id=>parent_attribute).first
      UnchainedCommerce::ProductAttribute.create(:product_id=>product_id,:attribute_map_id=>attribute_map.id)
      #puts "Added Attribute to Product" + attribute.name
      attribute_children = attribute.children
      unless attribute_children.blank?
        for child in attribute_children
          attribute_structure(child.attribute_code,product_id,attribute)
        end
      else
        return
      end
    end


    CSV.foreach(products_path, headers: true, encoding: 'iso-8859-1') do |product_attrs|
      # IMAGE ATTRIBUTES
      image_path = product_attrs["image"]
      product_attrs.delete("image")
      image_alt  = image_path.split('/')[-1]

      # PRODUCT TAXON
      primary_category = product_attrs["primary_category"].downcase.tr(" ","-")
      product_attrs.delete("primary_category")
      sub_category  = product_attrs["sub_category_tags"].downcase.tr(" ","-")
      product_attrs.delete("sub_category_tags")
      taxon_permalink = primary_category+"/"+sub_category
      taxon = Spree::Taxon.find_by_permalink!(taxon_permalink)
      default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
      

      slug = product_attrs["name"].tr(" ","-")
      product_object = Spree::Product.find_by_slug(slug)
      attributes = product_attrs["attribute_code"].split
      product_attrs.delete("attribute_code")

      if product_object
        Spree::Classification.create(:product_id=>product_object.id,:taxon_id=>taxon.id)
        #puts "Taxon association complete for " + product_attrs["name"]
      else
        product = Spree::Product.create!(default_attrs.merge(product_attrs).merge({slug:slug}))
        product.shipping_category = default_shipping_category
        product.master.images.create!(:attachment => image_path,:alt =>image_alt)
        product.save!
        Spree::Classification.create(:product_id=>product.id,:taxon_id=>taxon.id)

        product_attrs = product_attrs.to_hash
        attributes.map{|a|
          attribute_structure(a,product.id)
        }

        # CREATE A HASH FOR PRODUCT VARIANT
        variant_attr = {
          :product => product,
          :price => 0.0, 
          :weight => 0.0,
          :height => 0.0,
          :width => 0.0,
          :depth => 0.0,
          :cost_currency => 'USD' 
        }
        variant = Spree::Variant.create!(variant_attr)
        product.master.update_attributes!(variant_attr)
        variant.save!
        #puts "Creation complete for " + product_attrs["name"]
      end
    end
  end

  # RUN THIS TASK SECOND
  task :product_attribute_value => :environment do
    #UPDATE ALL THE ATTRIBUTE ENTRIES WITH VALUES
    products_attribute_values = Rails.root.join('db','import','values.csv')
    CSV.foreach(products_attribute_values, headers: true, encoding: 'iso-8859-1') do |product_value|
      product = Spree::Product.find_by_code(product_value["product_code"])
      attribute = UnchainedCommerce::Attribution.find_by_attribute_code(product_value["attribute_code"])
      unless product.blank?
        attribute_map = UnchainedCommerce::AttributeMap.where(:attribution_id=>attribute.id).first
        product_attribute = UnchainedCommerce::ProductAttribute.where(:product_id=>product.id,:attribute_map_id=>attribute_map.id)
        unless product_attribute.blank?
          product_attribute.first.update_attributes(:value=>product_value["attribute_value"])
        else
          puts "Attribute map not found"
        end
      else
        puts "Product with code" +product_value["product_code"]+ "was not found"
      end
    end
  end
end