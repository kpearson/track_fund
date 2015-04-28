FactoryGirl.define do
  factory :token do
    token "MyString"
    provider "MyString"
    user
  end

end
