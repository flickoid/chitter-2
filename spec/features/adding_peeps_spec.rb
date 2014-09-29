require 'spec_helper'

feature "User adds a new peep" do

  scenario "when browsing the homepage" do
    expect(Peep.count).to eq(0)
    visit '/'
    add_peep("Testing text 123")
    expect(Peep.count).to eq(1)
    peep = Peep.first
    expect(peep.content).to eq("Testing text 123")
  end

  def add_peep(content)
    within('#new-peep') do
      fill_in 'content', :with => content
      click_button 'Peep!'
    end
  end
end