require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should not save user without username or pin" do
    user = User.new
    assert_not user.save, "Saved the user with nothing"

    user = User.new
    user.pin = "0000"
    assert_not user.save, "Saved the user without username"

    user = User.new
    user.username = "abc"
    assert_not user.save, "Saved the user without pin"

    user = User.new
    user.username = "abc"
    user.pin = "0000"
    assert user.save, "Not saved even with username and pin"
  end

end
