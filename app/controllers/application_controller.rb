class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  # code actions here!

  get "/" do
    redirect to "/recipes"
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    @recipe = Recipe.create(params[:recipe])
    redirect to "/recipes/#{ @recipe.id }"
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    params.delete("_method")
    @recipe.update(params[:recipe])
    redirect to "/recipes/#{ @recipe.id }"
  end

  delete "/recipes/:id" do
    Recipe.destroy(params[:id])
    redirect to "/recipes"
  end

end
