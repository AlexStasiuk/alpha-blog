require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "Get new category formand create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do #Чи вийшло запостити одну категорію?
      post categories_path, params: { category: { name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end
end

