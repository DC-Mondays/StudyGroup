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

  factory :unconfirmed_user, class: User do
    email "unconfirmed@email.com"
    handle "unconfirmed"
    confirmation_token false
    admin false
  end
end
