class Purchase < ActiveRecord::Base
  attr_accessible :count, :customer_id, :item_id, :merchant_id, :customer, :item, :merchant

  belongs_to :customer
  belongs_to :item
end
