# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/contrib'
require 'json'

use Rack::MethodOverride

set :erb, escape_html: true

DATA_FILE = File.join(__dir__, 'data', 'memos.json')

def load_memos
  JSON.parse(File.read(DATA_FILE))
end

get '/memos' do
  @memos = load_memos
  erb :index
end

def save_memos(memos)
  File.write(DATA_FILE, JSON.generate(memos))
end

def next_id(memos)
  return 1 if memos.empty?

  memos.map { |memo| memo['id'] }.max + 1
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memos = load_memos
  new_memo = {
    'id' => next_id(memos),
    'title' => params[:title],
    'body' => params[:body],
    'created_at' => Time.now.iso8601
  }
  memos << new_memo
  save_memos(memos)
  redirect '/memos'
end

def find_memo(id)
  memos = load_memos
  memos.find { |memo| memo['id'] == id.to_i }
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
  memos = load_memos
  memo = memos.find { |m| m['id'] == params[:id].to_i }
  memo['title'] = params[:title]
  memo['body'] = params[:body]
  save_memos(memos)
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = load_memos
  memos.reject! { |m| m['id'] == params[:id].to_i }
  save_memos(memos)
  redirect '/memos'
end
not_found do
  status 404
  erb :not_found
end
