require 'debug'
FactoryBot.define do
  factory :booking do
    transient do
    end

    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    name { "#{first_name} #{last_name}" }
    email { "#{first_name[0]}#{last_name}@#{Faker::Internet.domain_name}".downcase }
    confirmation_code { Faker::Alphanumeric.alpha(number: 10).upcase }

    # Reset local variables between building passengers
    after(:build) do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
    end

    factory :booking_with_passengers do
      transient do
        passenger_count { 1 }
      end

      passengers do
        Array.new(passenger_count) { association(:passenger) }
      end
    end
  end
end
