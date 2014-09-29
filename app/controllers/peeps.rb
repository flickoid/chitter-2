post '/peeps' do
  content = params["content"]
  Peep.create(:content => content)
  redirect to('/')
end