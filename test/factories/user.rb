FactoryGirl.define do
  factory :user do
    email "test@email.com"
    handle  "Doe"
    admin false
    confirmed true
  end

  factory :admin_user, class: User do
    email "admin@email.com"
    handle  "Sys Admin"
    admin true
  end

  factory :unconfirmed_user, class: User do
    email "unconfirmed@email.com"
    handle "unconfirmed"
    confirmed false
    confirmation_token "4db8dd474ea55e8a827d2f5330e58dbb"
    admin false
  end
  
  
end
