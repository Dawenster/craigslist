get '/' do
  @all_categories = Categories.all
  erb :index
end

get '/create_post' do
  @all_categories = Categories.all
  erb :create_post
end

post '/created' do
  @secret_url = (0...45).map{ ('a'..'z').to_a[rand(26)] }.join
  params[:secret_url] = @secret_url
  Posts.create(params)
  # erb :created
  content_type :json
  params.to_json
end

get '/edit/:secret_url' do
  @all_categories = Categories.all
  @post = Posts.find_by_secret_url(params[:secret_url])
  erb :edit_post
end

post '/delete' do
  Posts.find_by_secret_url(params[:secret_url]).destroy
  redirect to '/'
end

post '/post_updated' do
  Posts.update(params[:id], params)
  redirect to '/'
end

get '/:category_id/:id' do
  @category = Categories.find(params[:category_id])
  @post = Posts.find(params[:id])
  erb :single_post
end

get '/:id' do
  @all_posts = Posts.where('category_id = ?', params[:id])
  erb :all_posts
end
