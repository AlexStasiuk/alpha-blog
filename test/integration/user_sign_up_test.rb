require "test_helper"

class UserSignUpTest < ActionDispatch::IntegrationTest
  def setup
    User.create(username: "pupkin10", email: "pupkin10@gmail.com",password: "password")
  end
  test "get new  user with correct username and email" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "pupkin", email: "pupkin@gmail.com", password: "password"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Pupkin", response.body
  end
  test "get new user with not correct email" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "Affffff", email: "pupkin@yy", password: "password"} }
    end
    assert_match "Email is invalid", response.body
  end
  test "get new user and reject invalid username" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "A", email: "pupkin@gmail.com", password: "password"} }
    end
    assert_match "Username is too short", response.body
  end
  test "get new user and reject existing username" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "pupkin10", email: "pupkin@gmail.com", password: "password"} }
    end
    assert_match "Username has already been taken", response.body
  end
  test "get new user and reject existing email" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "pupkin", email: "pupkin10@gmail.com", password: "password"} }
    end
    assert_match "Email has already been taken", response.body
  end
  test "get new user and reject blank username" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "", email: "pupkin@gmail.com", password: "password"} }
    end
    assert_match "blank", response.body
  end
  test "get new user and reject blank password" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "ffffff", email: "pupkin@gmail.com", password: ""} }
    end
    assert_match "blank", response.body
  end
  test "get new user and reject blank email" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "ffffff", email: "", password: "password"} }
    end
    assert_match "blank", response.body
  end
end
