#database configurations
configure do
  Mongoid.configure do |config|
    name = 'app'
    config.master = Mongo::Connection.new.db(name)
    config.persist_in_safe_mode = false
  end
end

class Image
  include Mongoid::Document
  field :title, type: String
end

get '/' do
  @image = Image.all
  haml :'index'
end

post '/' do
  @image = Image.new(title: params[:title])
  @image.save
  redirect '/'
end

get '/image/:id' do
  @image = Image.find(params[:id])
  haml :'show'
end

