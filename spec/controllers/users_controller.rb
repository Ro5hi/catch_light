require_relative "spec_helper"

def app
    UsersController
end

describe UsersController do
    it "responds with the user profile and a 200 status code" do
    get '/user'
    session[:user_id] = 1

    expect(last_response.body).to include('index')
    @user = User.create(username: "username", email: "user@email.com", password: "password")
end

it 'has a secure password' do
    expect(subject.authenticate('oops')).to eq(false)
    expect(subject.authenticate('farmer')).to eq(subject)
end

describe "GET '/register'" do 
    it 'returns a 200 status code' do 
      get '/register'
      expect(last_response.status).to eq(200)
    end

    it 'returns contains a form to register' do 
      visit '/register'
      expect(page).to have_selector("form")
      expect(page).to have_field(:password)
      expect(page).to have_field(:email)
    end
  end

  describe "POST '/signup'" do 
    it 'returns a 200 status code' do 
      visit '/register'
      fill_in "password", :with => "testpassword1"
      fill_in "email", :with => "test@test.com"
      
      click_button "Submit"
      expect(page.current_path).to eq('users/home')
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
        expect(page).to have_field(:email)
        expect(page).to have_field(:email)
    end
  end

  describe "POST '/login'" do
    it 'returns a 200 status code' do
      visit '/login'
      fill_in "email", :with => "email"
      fill_in "password", :with => "password"
      click_button "Login"
      expect(page.current_path).to eq('/index')
      expect(page.status_code).to eq(200)
    end

    it 'gets to post' do
      params = {
      "email"=> "email", "password" => "password"
      } 
      post '/login', params
        expect(last_response.status).to eq(302)
    end

  end
end