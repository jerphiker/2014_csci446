require 'test_helper'

class PetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "pet attributes must not be empty" do
    pet = Pet.newassert pet.invalid?
    assert pet.errors[:petType].any?
    assert pet.errors[:name].any?
    assert pet.errors[:breed].any?
    assert pet.errors[:description].any?
    assert pet.errors[:image_url].any?
  end
end
