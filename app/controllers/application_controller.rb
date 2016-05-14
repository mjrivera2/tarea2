class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json

  def buscar
    if(!params.key?(:tag) or !params.key?("access_token"))
      render status: 400, json: "Bad request"
    else
      @tags_json = HTTParty.get('https://api.instagram.com/v1/tags/'+ params[:tag] +'/media/recent?access_token='+ params["access_token"] + '&count=20')
      @tags_count = HTTParty.get('https://api.instagram.com/v1/tags/' + params[:tag]+ '?access_token=9994244.1fb234f.8893dfbb48d840aab8ea4b3e92be20e7')["data"]["media_count"]
      @tags = JSON.parse(@tags_json.body)
      @new_tags = []
      if(@tags != nil)
        @tags["data"].each do |tag|
          if(tag["images"].key?("standard_resolution"))
            @url = tag["images"]["standard_resolution"]["url"]
          elsif(tag["images"].key?("low_resolution"))
            @url = tag["images"]["low_resolution"]["url"]
          else
            @url = tag["images"]["thumbnail"]["url"]
          end
          @new_tag = {
              tags: tag["tags"],
              username: tag["user"]["username"],
              likes: tag["likes"]["count"],
              url: @url,
              caption: tag["caption"]["text"]
          }
          @new_tags << @new_tag
        end
        render status: 200, json: {metadata: {total: @tags_count}, posts: @new_tags, version: "0.2.0"}
      else
        render status: 404, json: "Not found"
      end

    end
  end
  #Metodo para retornar Json
  def self.respond_to(*mimes)
    include ActionController::RespondWith::ClassMethods
  end
end
