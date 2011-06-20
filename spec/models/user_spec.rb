require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :email => "user@example.com",
      :password => "foobar"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require an email address" do
    user = User.new(@attr.merge(:email => ""))
    user.should_not be_valid
  end
  
  it "should require a password" do
    user = User.new(@attr.merge(:password => ""))
    user.should_not be_valid
  end
  
  it "should require a valid email address" do
    user = User.new(@attr.merge(:email => "not an email address"))
    user.should_not be_valid
  end
  
  it "should reject an existing email address" do
    User.create!(@attr)
    user = User.new(@attr)
    user.should_not be_valid
  end
end
