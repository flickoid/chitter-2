module SessionHelpers

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

  def sign_in(username, password)
    visit '/sessions/new'
    expect(page.status_code).to eq(200)
    fill_in :username, :with => username
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end