class Booking < ApplicationRecord
  belongs_to :flight

  has_many :passengers, dependent: :destroy
  accepts_nested_attributes_for :passengers

  before_save :generate_confirmation_code, unless: :confirmation_code?

  private

  def generate_confirmation_code
    self.confirmation_code = self.class.generate_unique_confirmation_code
  end

  class << self
    def generate_unique_confirmation_code
      code = generate_code while code.nil? || Booking.exists?(confirmation_code: code)
      code
    end

    def generate_code(length = 10)
      code = String.new
      length.times { code << rand(65..90).chr }

      code
    end
  end
end
