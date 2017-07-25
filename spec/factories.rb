FactoryGirl.define do
  factory :car_registration do
    user
    contract_address "0x00"
    contract_abi ""
  end
  factory :role do
  end

  factory :user do
    email "test@test.test"
    password "secretpassword"
    password_confirmation "secretpassword"
    firstname "First"
    lastname "last"
    after(:build, &:skip_confirmation_notification!)
  end

  factory :confirmed_user, parent: :user do
    after(:create, &:confirm)
  end
end
