require 'sinatra/base'
require 'haml'

class HowManyDays < Sinatra::Base
    get '/' do
      begin
        @date = Date.parse(params[:date]) if params[:date]
      rescue => ex
        @msg = "#{ex.message.capitalize}: #{params[:date]}"
      end
      @days = (@date - Date.today) if @date
      haml :index
    end
end
