require 'spec_helper'

describe Import do
  describe '.import' do
    subject do
      Import.import("purchaser name	item description	item price	purchase count	merchant address	merchant name
Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza
Amy Pond	$30 of awesome for $10	10.0	5	456 Unreal Rd	Tom's Awesome Shop
Marty McFly	$20 Sneakers for $5	5.0	1	123 Fake St	Sneaker Store Emporium
Snake Plissken	$20 Sneakers for $5	5.0	4	123 Fake St	Sneaker Store Emporium", 'file_name')
    end
    it 'should create all unique customers' do
      subject

      Customer.count.should == 3
    end

    it 'should set the customers name' do
      subject

      Customer.first.name.should == "Snake Plissken"
    end

    it 'should create the unique items' do
      subject

      Item.count.should == 3
    end

    it 'should set the description' do
      subject

      Item.first.description.should == '$10 off $20 of food'
    end

    it 'should set the price' do
      subject
      Item.first.price.should == 10.0
    end

    it 'should create the unique merchants' do
      subject

      Merchant.count.should == 3
    end

    it 'should set the merchant name' do
      subject

      Merchant.first.name.should == "Bob's Pizza"
    end

    it 'should set the merchant address' do
      subject

      Merchant.first.address.should == '987 Fake St'
    end

    it 'should assign the coupon to the merchant' do
      subject

      Merchant.last.items.first.description.should == '$20 Sneakers for $5'
    end

    it 'should only assign the same coupon once' do
      subject

      Merchant.last.items.count.should == 1
    end

    it 'should create the purchase' do
      subject

      Purchase.count.should == 4
    end

    it 'should set the count of the items purchased' do
      subject

      Purchase.first.count.should == 2
    end


    it 'should set the customer for the purchase' do
      subject

      Purchase.first.customer.name.should == 'Snake Plissken'
    end

    it 'should set the item for the purchase' do
      subject

      Purchase.first.item.description.should == '$10 off $20 of food'
    end

    it 'should return all created purchases' do
      subject.should be_instance_of Import
    end


    it 'should assign all of the purchases to the import' do
      subject.purchases.should == Purchase.all
    end
  end
end
