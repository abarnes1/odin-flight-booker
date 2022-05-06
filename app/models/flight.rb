class Flight < ApplicationRecord
  belongs_to :departure_airport, -> { readonly }, class_name: 'Airport'
  belongs_to :arrival_airport, -> { readonly }, class_name: 'Airport'
end
