FactoryGirl.define do
  factory :user do
    email "test@email.com"
    handle  "JohnDoe"
    password "stub password"
    password_salt "abcde"
    admin false
    confirmed true
  end

  factory :admin_user, class: User do
    email "admin@email.com"
    handle  "Sys Admin"
    password "$2a$10$yEvEmqypNJ1xIfveyqBlneEjORAm2SqtG0nohuiVwed.i3.lf4JvO"
    password_salt "efghij"
    admin true
  end

  factory :unconfirmed_user, class: User do
    email "unconfirmed@email.com"
    handle "unconfirmed"
    password nil
    password_salt nil
    confirmed false
    confirmation_token "4db8dd474ea55e8a827d2f5330e58dbb"
    admin false
  end


end
