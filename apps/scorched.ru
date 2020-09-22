require 'scorched'

class App < Scorched::Controller
  get '/' do
    'Hello World!'
  end
end

run App
