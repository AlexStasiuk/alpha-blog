require "test_helper"

class NewArticleCreationTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "Ivan", email:"adminemail@gmail.com", password:"password", admin: true)
    sign_in_as(@admin_user)
  end
  # test "the truth" do
  #   assert true
  # end
  test "Get new article formand create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do 
      post articles_path, params: { article: { title: "Sports", description: "Description example"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end
  test "Get new article formand create article with blank title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do 
      post articles_path, params: { article: { title: "", description: "Description example"} }
    end
    assert_match "blank", response.body
  end
  test "Get new article formand create article with blank description" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do 
      post articles_path, params: { article: { title: "Sports", description: ""} }
    end
    assert_match "blank", response.body
  end
  test "Get new article formand create article with too short title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do 
      post articles_path, params: { article: { title: "Spo", description: "Description example"} }
    end
    assert_match "short", response.body
  end
  test "Get new article formand create article with too long title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do 
      post articles_path, params: { article: { title: "SpoDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription exampleDescription example",
         description: "Description example"} }
    end
    assert_match "long", response.body
  end

  test "Get new article formand create article without login" do
    logout_as(@admin_user)
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    get "/articles/new"
    assert_redirected_to login_path
    assert_no_difference 'Article.count' do 
      post articles_path, params: { article: { title: "Description example", description: "Description example"} }
    end
    # assert_match "perform", response.body
  end
end
