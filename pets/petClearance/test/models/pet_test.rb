require 'test_helper'

class PetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "pet attributes must not be empty" do
    pet = Pet.new
    assert pet.invalid?
    assert pet.errors[:petType].any?
    assert pet.errors[:name].any?
    assert pet.errors[:breed].any?
    assert pet.errors[:description].any?
    assert pet.errors[:image_url].any?
  end
  
  def new_pet(image_url)
    Pet.new(
      petType: "testType",
      name: "testName",
      breed: "testBreed",
      description: "test test test",
      image_url: image_url
    )
  end
  test "image url" do
    ok = %w{ dog.gif dog.jpg dog.png DOG.GIF DOG.Gif http://a.b.c/x/y/z/dog.gif }
    bad = %w{ dog.doc dog.gif/more dog.gif.more }
    ok.each do |name|
      assert new_pet(name).valid?, "#{name} should be valid"
    end
    bad.each do |name|
      assert new_pet(name).invalid?, "#{name} should be invalid"
    end
  end
end
