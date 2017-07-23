FactoryGirl.define do
  factory :user do
    email "test@test.test"
    password "secretpassword"
    password_confirmation "secretpassword"
    firstname "First"
    lastname "last"
    after(:build, &:skip_confirmation_notification!)
  end

  factory :confirmed_user, parent: :user do
    after(:create, &:confirm!)
  end
end
