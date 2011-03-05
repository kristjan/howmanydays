require 'sinatra/base'
require 'haml'

class HowManyDays < Sinatra::Base
    get '/' do
      @date = Date.parse(params[:date]) if params[:date]
      @days = (@date - Date.today) if @date
      haml :index
    end
end
