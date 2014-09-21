#database configurations
configure do
  Mongoid.configure do |config|
    name = 'app'
    config.master = Mongo::Connection.new.db(name)
    config.persist_in_safe_mode = false
  end
end

class ImageUploader < CarrierWave::Uploader::Base
  storage :file
end

class Image
  include Mongoid::Document
  mount_uploader :image, ImageUploader, type: String
  field :title, type: String
end

get '/' do
  @images = Image.all
  haml :index
end

post '/' do
  @image = Image.new(title: params[:title])
  @image.image = params[:image]
  @image.save
  redirect '/'
end

get '/image/:id' do
  @image = Image.find(params[:id])
  haml :show
end

