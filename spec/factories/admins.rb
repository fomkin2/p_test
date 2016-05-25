FactoryGirl.define do
  # sequence :email do |n|
  #   "person#{n}@example.com"
  # end

  factory :admin do
    email
    password 'password'
  end
end
