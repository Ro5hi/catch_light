# require_relative "spec_helper"

    def app
        ApplicationController
    end

    describe "GET '/'" do 
        it 'returns a 200 status code' do 
        get 'users/home'
         
    end 

end 