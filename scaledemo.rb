
  require 'rubygems'
  require 'sinatra'
  require 'yaml'
  require 'json'

  set :requests, 0

  get '/' do
     settings.requests += 1     
     app_info = JSON.parse(ENV['VCAP_APPLICATION'])     
     ENV['APP_NAME'] = app_info["application_name"]
     ENV['APP_INSTANCE'] = app_info["instance_index"].to_s
     ENV['APP_MEM'] = app_info["limits"]["mem"].to_s
     ENV['APP_DISK'] = app_info["limits"]["disk"].to_s
     ENV['APP_IP'] = IPSocket.getaddress(Socket.gethostname)
     ENV['APP_PORT'] = app_info["port"].to_s
     erb :'index'
  end
  
  get '/killSwitch' do
    Kernel.exit!
  end
  
  get '/load' do
    i = 0
    buff = ""

    while i < 1000  do
      buff += i.to_s
      buff.reverse!
      i += 1
    end
    settings.requests += 1
    "<h2>I'm healthy!</h2>"
  end
  
  get '/health' do
    settings.requests += 1
    "<h2>I'm healthy!</h2>"
  end


