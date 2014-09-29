require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do

  scenario "when being logged out" do
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, tester")
    expect(User.first.username).to eq("tester")
  end

  scenario "with a password that doesn't match" do
    expect{ sign_up("Test Tester", "tester", "test@test.com", "testword", "wrongword") }.to change(User, :count).by (0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "with an email that is already registered" do
    expect{ sign_up }.to change(User, :count).by (1)
    expect{ sign_up }.to change(User, :count).by (0)
    expect(page).to have_content("This email is already taken")
  end

end

feature "User signs in" do

  before(:each) do
    User.create(:name => "Test Tester", :username => "tester", :email => "test@test.com", :password => "testword", :password_confirmation => "testword")
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, tester")
    sign_in('tester', 'testword')
    expect(page).to have_content("Welcome, tester")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, tester")
    sign_in('tester', 'wrongword')
    expect(page).not_to have_content("Welcome, tester")
  end

end

feature "User signs out" do

  before(:each) do
    User.create(:name => "Test Tester", :username => "tester", :email => "test@test.com", :password => "testword", :password_confirmation => "testword")
  end

  scenario "while being signed in" do
    sign_in('tester', 'testword')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, tester")
  end
end