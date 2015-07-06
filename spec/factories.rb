FactoryGirl.define do

  factory :user do
    sequence(:username)   { |n| "Person #{n}" }
    sequence(:email)      { |n| "person_#{n}@example.com"}
    password              "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :playlist do
    name                  "Lorem Ipsum"
    keycode               "loremipsum"
    # user_id               19
    user
  end

end
