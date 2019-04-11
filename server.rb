require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/flash'
require "pry" if development? || test?
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

configure do
  set :views, 'app/views'
end

enable :sessions

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  redirect '/parties'
end

get '/parties' do
  @parties  = Party.all
  erb :'parties/index'
end

get '/friends' do
  @friends = Friend.all.order(first_name: :asc)
  erb :'friends/index'
end

get '/parties/guestlist/:id/uninvite' do
  invite = PartyInvite.find(params[:id])
  invite.delete
  redirect back
end

get '/parties/guestlist/:id/rsvp' do
  invite = PartyInvite.find(params[:id])
  invite.attending = true
  invite.save
  redirect back
end

get '/parties/:id' do
  @party = Party.find(params[:id])
  @friends = Friend.all.order(first_name: :asc)
  erb :'parties/show'
end

get '/parties/:id/edit' do
  @party = Party.find(params[:id])

  erb :'parties/edit'
end

get '/new' do
  erb :'parties/new'
end

get '/friend/new' do
    erb :'friends/new'
end

post '/new' do
  party = Party.new(name: params[:name], description: params[:description], location: params[:location])
  if party.valid?
    party.save
    redirect '/parties'
  else
    @errors = party.errors.full_messages
    @name = params[:name]
    @description = params[:description]
    @location = params[:location]
    erb :'parties/new'
  end

end

post '/friend/new' do
  friend = Friend.new(first_name: params[:first_name], last_name: params[:last_name])
  if friend.valid?
    friend.save
    redirect '/friends'
  else
    @errors = friend.errors.full_messages
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    erb :'/friends/new'
  end
end

post '/invite' do
  PartyInvite.create(party_id: params[:party], friend_id: params[:friend])
  redirect "/parties/#{params[:party]}"
end

post '/parties/:id/edit' do
  @party = Party.find(params[:id])
  @party.name = params[:name]
  @party.description = params[:description]
  @party.location = params[:location]
  if @party.valid?
    @party.save
    redirect "/parties/#{params[:id]}"
  else
    @errors = @party.errors.full_messages
    erb :'parties/edit'
  end
end

get '/parties/:id/delete'do
  party = Party.find(params[:id])
  party.delete
  redirect '/parties'
end

get '/friends/:id/delete'do
  friend = Friend.find(params[:id])
  friend.delete
  redirect '/friends'
end
