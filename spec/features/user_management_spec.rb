require 'spec_helper'

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

  def sign_up(name = "Test Tester", username = "tester", email = "test@test.com", password = "testword", password_confirmation = "testword")
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end
end

feature "User signs in" do

  before(:each) do
    User.create(:name => "Test Tester", :username => "tester", :email => "test@test.com", :password => "testword", :password_confirmation => "testword")
  end

  def sign_in(username, password)
    visit '/sessions/new'
    expect(page.status_code).to eq(200)
    fill_in :username, :with => username
    fill_in 'password', :with => password
    click_button 'Sign in'
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




























