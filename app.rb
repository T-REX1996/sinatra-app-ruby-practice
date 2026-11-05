# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/contrib'
require_relative 'lib/memo'

use Rack::MethodOverride

set :erb, escape_html: true

def find_memo(id)
  Memo.find(id) || halt(404)
end

get '/memos' do
  @memos = Memo.all
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  Memo.create(title: params[:title], body: params[:body])
  redirect '/memos'
end

get '/memos/:id' do
  @memo = find_memo(params[:id])
  erb :show
end

get '/memos/:id/edit' do
  @memo = find_memo(params[:id])
  erb :edit
end

patch '/memos/:id' do
  find_memo(params[:id])
  Memo.update(id: params[:id], title: params[:title], body: params[:body])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  Memo.destroy(params[:id])
  redirect '/memos'
end

not_found do
  status 404
  erb :not_found
end
