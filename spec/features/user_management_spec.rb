require 'spec_helper'

feature "User signs up" do

  scenario "when being logged out" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, tester")
    expect(User.first.username).to eq("tester")
  end

  def sign_up(name = "Test Tester", username = "tester", email = "test@test.com", password = "testword")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end
end