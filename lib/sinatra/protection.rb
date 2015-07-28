require "sinatra/contrib"

module Sinatra
  Protection = Sinatra::Extension.new do
    set :username, "admin"
    set :password, "admin"
    set :realm, "Restricted Area"
    set :enable_protection, true

    helpers do
      def protected!
        return unless settings.enable_protection
        return if authorized?
        headers['WWW-Authenticate'] = "Basic realm=\"#{settings.realm}\""
        halt 401, "Not authorized\n"
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [settings.username, settings.password]
      end
    end
  end

  register Protection
end

require "sinatra/protection/version"
