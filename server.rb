require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_2_#{env}")

require './lib/peep'

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @peeps = Peep.all
  erb :index
end