require 'sinatra/base'
require 'haml'

class HowManyDays < Sinatra::Base
    get '/' do
      begin
        @start_date = parse_date(params[:start_date])
        @end_date   = parse_date(params[:end_date])
      rescue => ex
        @msg = "#{ex.message.capitalize}: #{params[:start_date]}, #{params[:end_date]}"
      end
      @start_date ||= Date.today
      @days = (@end_date - @start_date) if @start_date && @end_date
      haml :index
    end

    def parse_date(date)
      return nil if date.nil? || date.empty?
      match = %r[(\d{1,2})/(\d{1,2})/(\d{2})].match(date)
      if match
        return Date.new(match[3].to_i + 2000, match[1].to_i, match[2].to_i)
      end
      Date.parse(date)
    end
end
