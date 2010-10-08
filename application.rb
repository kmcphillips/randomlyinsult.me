require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  def a_or_an(phrase)
    if %w{a e i o u}.include? phrase.downcase[0..0]
      "An"
    else
      "A"
    end
  end
end

# root page
get '/' do
  @insult = Insult.generate
  haml :index
end
