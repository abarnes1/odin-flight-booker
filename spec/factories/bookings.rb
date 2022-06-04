require 'debug'
FactoryBot.define do
  factory :booking do
    transient do
      flight { nil }
    end

    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    flight_id { flight&.id }
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

      after(:build) do |booking, evaluator|
        evaluator.passenger_count.times { booking.passengers << build(:passenger) }
      end

      after(:create) do |booking, _evaluator|
        booking.passengers.each { |passenger| passenger.booking_id = booking.id }
      end
    end
  end
end
