require 'sinatra/base'
require 'haml'

class HowManyDays < Sinatra::Base
    get '/' do
      begin
        @start_date = Date.parse(params[:start_date]) if params[:start_date]
        @end_date   = Date.parse(params[:end_date]) if params[:end_date]
      rescue => ex
        @msg = "#{ex.message.capitalize}: #{params[:start_date]}, #{params[:end_date]}"
      end
      @start_date ||= Date.today
      @days = (@end_date - @start_date) if @start_date && @end_date
      haml :index
    end
end
