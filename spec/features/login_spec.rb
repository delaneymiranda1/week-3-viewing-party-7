require 'rails_helper' 

RSpec.describe "Login Page for user", type: :feature do

  
  
  
  #   As a registered user
  # When I visit the landing page `/`
  # I see a link for "Log In"
  # When I click on "Log In"
  # I'm taken to a Log In page ('/login') where I can input my unique email and password.
  # When I enter my unique email and correct password 
  # I'm taken to my dashboard page

  it 'landing page has a link for login, that takes you to the login page to fill out form' do
    user1 = User.create(name: 'User One', email: 'johndoe@example.com', password: 'password123', password_confirmation: 'password123')
    visit '/'

    click_on 'Log In'
    expect(current_path).to eq('/login')
    
    fill_in :email, with:'johndoe@example.com'
    fill_in :password, with: 'password123'
    click_on 'Log In'

    expect(current_path).to eq(user_path(user1.id))

  end

  #   As a registered user
  # When I visit the landing page `/`
  # And click on the link to go to my dashboard
  # And fail to fill in my correct credentials 
  # I'm taken back to the Log In page
  # And I can see a flash message telling me that I entered incorrect credentials. 

  it 'redirects to log in page if credentials are wrong' do
    user1 = User.create(name: 'User One', email: 'johndoe@example.com', password: 'password123', password_confirmation: 'password123')
    visit login_path 

    fill_in :email, with:'johndoe@example.com'
    fill_in :password, with: 'password1234'
    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end