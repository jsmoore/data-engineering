class Item < ActiveRecord::Base
  attr_accessible :description, :price

  belongs_to :merchant
end
