require 'spec_helper'

feature "User browses the list of peeps" do

  before(:each) do
    Peep.create(:content => "Testing text 123")
  end

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Testing text 123")
  end
end