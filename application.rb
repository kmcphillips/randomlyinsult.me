require 'rubygems'
require 'sinatra/base'

class Insulter < Sinatra::Base
  configure do
    set :views, "#{File.dirname(__FILE__)}/views"
    set :run, false
    set :environment, :production

    FileUtils.mkdir_p 'log' unless File.exists?('log')
    log = File.new("log/sinatra.log", "a+")
    $stdout.reopen(log)
    $stderr.reopen(log)
    
    SiteConfig = OpenStruct.new(
                 :title => 'Randomly Insult Me',
                 :author => 'Kevin McPhillips',
                 :url_base => 'http://randomlyinsult.me'
                 )

    $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
    Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
  end

  error do
    e = request.env['sinatra.error']
    Kernel.puts e.backtrace.join("\n")
    'Application error'
  end

  helpers do
    def a_or_an(phrase)
      if %w{a e i o u}.include? phrase.downcase[0..0]
        "an"
      else
        "a"
      end
    end
  end

  # root page
  get '/' do
    @insult = Insult.generate
    haml :index
  end

  get '/:prefix/:postfix' do
    @insult = Insult.new(params[:prefix], params[:postfix])
    haml :index
  end
end
