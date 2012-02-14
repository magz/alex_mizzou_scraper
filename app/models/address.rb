class Address < ActiveRecord::Base
  validates :encoded_address, :uniqueness => true

end
