FactoryGirl.define do
  sequence :title do |n|
    "product#{n}"
  end
  factory :product do
    title
    introduction 'product introduction'
    description 'product description'
    information 'information'
    published true
    price 999
    link 'http://link.com'
  end
end
