require_relative "spec_helper"

def app 
    PhotosController
end 

    describe "GET '/photos'" do 
        it "responds with a 200 status code'" do
        visit '/recent'
    end 

    describe "POST '/photos/upload'" do 
        it 'allows the user to upload photos'
        get '/photos/new'
    end

    describe "GET '/photos/:id'" do 
        it 'obtains the photo id' do 
        get '/photos'
        visit '/photos/:id'
        expect(photo.user_id)to_eq(user.id)
    end 

    describe "POST '/photos/:id'" do 
        it 'redirects user to photo' do 
        get '/photos/:id'
    end 

end 