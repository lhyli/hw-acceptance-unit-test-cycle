require 'rails_helper'

describe MoviesController, type: 'controller' do
    let(:movies) { ['star wars', 'raiders'] }    

    describe 'Search movies by the same director' do
      it 'should call Movie.similar_movies' do
        expect(Movie).to receive(:similar_movies).with('Aladdin')
        get :search, { title: 'Aladdin' }
      end
  
      it 'should assign similar movies if director exists' do
        movies = ['Seven', 'The Social Network']
        Movie.stub(:similar_movies).with('Seven').and_return(movies)
        get :search, { title: 'Seven' }
        expect(assigns(:similar_movies)).to eql(movies)
      end
  
      it "should redirect to home page if director isn't known" do
        Movie.stub(:similar_movies).with('No name').and_return(nil)
        get :search, { title: 'No name' }
        expect(response).to redirect_to(root_url+"movies")
      end
    end

    describe "create" do
      let(:params) {{:title => "Alien"}}
      let(:movie) {double('movie', params)}
    
      it 'calls the create method to create a new movie' do
        expect(Movie).to receive(:create!).with(params).and_return(movie)
        post :create, {movie: params}  
      end
    end
    
    describe "destroy" do
      let(:movie) {double('movie',:title => 'Shrek')}
      let(:id) {'200'}
      
      it 'calls the find method to retrieve a movie' do
        expect(Movie).to receive(:find).with(id).and_return(movie)
        allow(movie).to receive(:destroy)
        delete :destroy, {:id => id}
      end
    end
  end
  