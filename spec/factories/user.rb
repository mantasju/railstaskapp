FactoryBot.define do
  factory :invalid_email_user, class: User do
    username 'asdasd'
    password 'asdasd'
    email 13
    age 15
  end

  factory :user do
    username 'asdasd'
    password 'asdasd'
    email 'a@a.a'
    age 15
  end

  factory :test_user, class: User do
    username 'testuser'
    password 'testuser'
    email 'a@a.a'
    age 15
  end
end