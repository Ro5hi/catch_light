require_relative "spec_helper"

def app
  ApplicationController
end


describe ApplicationController do
    it "responds with the user profile and a 200 status code" do
        get '/user'
        session[:user_id] = 1

        # expect(last_response.body).to include('index')
        # @user = User.create(username: "username", email: "user@email.com", password: "password")
    end

it 'has a secure password' do
        expect(subject.authenticate('oops')).to eq(false)
        expect(subject.authenticate('farmer')).to eq(subject)
end

end 