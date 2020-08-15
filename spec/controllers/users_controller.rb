require_relative "spec_helper"

def app
    UsersController
end

describe "GET '/register'" do 
    it 'returns a 200 status code' do 
      get '/register'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a form to register' do 
      visit '/register'
      expect(page).to have_selector("form")
      expect(page).to have_field(:username)
      expect(page).to have_field(:password)
      expect(page).to have_field(:email)
    end
  end

  describe "POST '/register'" do 
    it 'returns a 200 status code' do 
      visit '/register'
      fill_in "username", :with => "testaccount1"
      fill_in "password", :with => "testpassword1"
      fill_in "email", :with => "test@test.com"
      
      click_button "Submit"
      expect(page.current_path).to eq('/home')
      expect(page.status_code).to eq(200)
    end
  end

  describe "GET '/login'" do
    it 'returns a 200 status code' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'returns a form to login' do
      visit '/login'
        expect(page).to have_field(:username)
        expect(page).to have_field(:password)
    end
  end

  describe "POST '/login'" do
    it 'returns a 200 status code' do
      visit '/login'
      fill_in "username", :with => "username"
      fill_in "password", :with => "password"
      click_button "Login"
      expect(page.current_path).to eq('/index')
      expect(page.status_code).to eq(200)
    end

    it 'gets to post' do
      params = {
      "username"=> "username", "password" => "password"
      } 
      post '/login', params
        expect(last_response.status).to eq(302)
    end

  end
end