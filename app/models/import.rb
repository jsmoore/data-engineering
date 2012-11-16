require 'csv'

class Import < ActiveRecord::Base
  has_many :purchases
  attr_accessible :file_name
  def self.import(file_data, file_name)
    import = Import.create file_name: file_name
    CSV.parse(file_data, :col_sep => "\t", :headers => true) do |row|
      customer = Customer.find_or_create_by_name row[0]

      item = Item.find_or_create_by_description row[1]
      item.update_attributes price: row[2]

      merchant = Merchant.find_or_create_by_name row[5]
      merchant.update_attributes address: row[4]

      merchant.items << item
      merchant.save

      import.purchases << Purchase.create(count: row[3], customer: customer, item: item)
    end

    import
  end
end
