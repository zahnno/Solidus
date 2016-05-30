require 'csv'
require 'open-uri'

# Before running this script ensure that allthe products are in the database

namespace :import do
  desc "Import products from csv"
  task :attribute_metadata => :environment do
    products_path = Rails.root.join('db','import','attribute_metadata.csv')
    CSV.foreach(products_path, headers: true, encoding: 'iso-8859-1') do |attributes|
      attributes_hash = attributes.to_hash
      attribute_name  = attributes_hash["name"]
      attribute_code  = attributes_hash["attribute_code"]
      attribute_name.strip!
      attribute_code.strip!
      already_exist = UnchainedAttribution.find_by_attribute_code(attribute_code)
      unless already_exist
        puts "Creating " + attribute_name
        UnchainedAttribution.create(:name=>attribute_name,:attribute_code=>attribute_code)
      else
        puts "Already have " + attribute_name
      end
    end
  end

  task :attribute_map => :environment do
    products_path = Rails.root.join('db','import','attribute_metadata.csv')
    CSV.foreach(products_path, headers: true, encoding: 'iso-8859-1') do |attributes|
      attributes_hash = attributes.to_hash
      attribute_code  = attributes_hash["attribute_code"] ? attributes_hash["attribute_code"] : ""
      parent_attribute_code  = attributes_hash["parent_code"] ? attributes_hash["parent_code"] : ""

      attribute_code.strip!
      parent_attribute_code.strip!

      attribute_id = UnchainedAttribution.find_by_attribute_code(attribute_code).id     

      unless parent_attribute_code == ""
        parent_attribute_id = UnchainedAttribution.find_by_attribute_code(parent_attribute_code).id
      else
        parent_attribute_id = nil
      end
      attribute_map = UnchainedAttributeMap.where(:attribution_id=>attribute_id, :parent_attribute_id=>parent_attribute_id).first
      unless attribute_map
        puts "Creating new Attribute Map"
        attribute_map = UnchainedAttributeMap.create(:attribution_id=>attribute_id, :parent_attribute_id=> parent_attribute_id)
      end
    end
  end

  task :category_metadata => :environment do
    products_path = Rails.root.join('db','import','product_list.csv')
    CSV.foreach(products_path, headers: true, encoding: 'iso-8859-1', :header_converters => :symbol) do |attributes|
      primary_category = UnchainedCategory.find_by_name(attributes[:primary_category])
      sub_category = UnchainedCategory.find_by_name(attributes[:sub_category_tags])
      unless primary_category
        puts "Creating " + attributes[:primary_category_tags]
        UnchainedCategory.create(:name=> attributes[:primary_category_tags])
      end
      unless sub_category
        puts "Creating " + attributes[:sub_category_tags]
        UnchainedCategory.create(:name=> attributes[:sub_category_tags])
      end
    end
  end

  task :category_map
end