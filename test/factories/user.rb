FactoryGirl.define do
  factory :user do
    email "test@email.com"
    handle  "Doe"
    admin false
  end
  
  factory :admin_user, class: User do
    email "admin@email.com"
    handle  "Sys Admin"
    admin true
  end
end
