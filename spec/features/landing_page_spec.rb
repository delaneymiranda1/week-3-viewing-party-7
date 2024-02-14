require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123', password_confirmation: 'password123')
    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123', password_confirmation: 'password123')
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    visit login_path 

    user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123', password_confirmation: 'password123')

    fill_in "Email:", with: user1.email
    fill_in "Password:", with: user1.password
    fill_in "Location:", with: "Denver, CO"

    click_button "Log In"

    visit '/'

    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123', password_confirmation: 'password123')

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  it 'does not show visitors (logged out users) existing user info' do
    visit '/'

    expect(page).to_not have_content("Existing Users:")
  end

  it 'does not show logged in users links to exisiting users show pages' do
    visit login_path 

    user1 = User.create(name: "User One", email: "user1@test.com", password: 'password123', password_confirmation: 'password123')
    user2 = User.create(name: "User Two", email: "user2@test.com", password: 'password123', password_confirmation: 'password123')

    fill_in "Email:", with: user1.email
    fill_in "Password:", with: user1.password
    fill_in "Location:", with: "Denver, CO"

    click_button "Log In"

    visit '/'
    
    expect(page).to_not have_link("user1@test.com")
    expect(page).to_not have_link("user2@test.com")
  end

  it 'remains on the landing page if you are not logged in and you try to visit a users show page' do
    user123 = User.create(name: "User OneTwoThree", email: "user123@test.com", password: 'password123', password_confirmation: 'password123')
    visit '/'
    # require 'pry'; binding.pry
    visit user_path(user123)

    expect(current_path).to eq('/')
    expect(page).to have_content("Must be logged in or registered to access a user's dashboard.")
  end
end
