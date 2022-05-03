class Airport < ApplicationRecord
  before_save :standardize_case

  private

  def standardize_case
    code.upcase!
    name.capitalize!
  end
end
