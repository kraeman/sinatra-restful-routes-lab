require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe1 = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end


  post '/recipes' do

    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
   
    redirect to "/recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find(params[:id]).delete
    redirect "/recipes"
  end

  patch "/recipes/:id" do

    recipe = Recipe.find(params[:recipes][:id])
    recipe.name = params[:recipes][:name]
    recipe.ingredients = params[:recipes][:ingredients]
    recipe.cook_time = params[:recipes][:cook_time]
    
    redirect "/recipes/#{recipe.id}"
  end

end
