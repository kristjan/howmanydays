require 'sinatra/base'
require 'haml'

SATURDAY = 5

class HowManyDays < Sinatra::Base
  get '/' do
    begin
      @start_date = parse_date(params[:start_date])
      @end_date   = parse_date(params[:end_date])
    rescue => ex
      @msg = <<-MSG
        #{ex.message.capitalize}:
        #{params[:start_date].inspect}, #{params[:end_date].inspect}
      MSG
    end
    @exclude_weekends = !!params[:exclude_weekends]
    @start_date ||= Date.today
    @days = count_days(@exclude_weekends) if @start_date && @end_date
    haml :index
  end

  def count_days(exclude_weekends)
    exclude_weekends ?
      (@start_date..@end_date).count{|date| date.cwday < SATURDAY} :
      @end_date - @start_date
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
