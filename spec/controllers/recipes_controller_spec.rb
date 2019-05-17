require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  before(:each) do
    @user = User.create(name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456')
    session[:user_id] = @user.id

  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      recipe = Recipe.create(name: 'Lasagne', description: 'Tastes real nice', user_id: @user.id)
      get :new, params: {id: recipe.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new recipe" do
      post :create, :params => { recipe: { :name => "Test recipe", :description => "Test description" } }
      expect(Recipe.find_by(name: 'Test recipe')).to_not eq nil
    end

    it "does not create a recipe if user is not logged in" do
      session.delete(:user_id)
      expect(Recipe).to_not receive(:create)
      post :create, :params => { recipe: { :name => "Test recipe", :description => "Test description" } }
    end
  end
end
