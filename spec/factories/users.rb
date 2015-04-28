FactoryGirl.define do
  factory :user do
    uid "MyString"
    provider "facebook"
    first_name "Sally"
    gender "female"
    last_name "Raphael"
    link "facebook.com"
    locale "johannesburg"
    name "Sally Jessy Raphael"
    token "tokenstring"
  end
end
