require 'rails_helper'

describe Movie do
  
  context 'other movies by that director' do
    it 'finds movies with same director' do
      @movie1 = Movie.create(title: "Other1", director: "Director")
      @movie2 = Movie.create(title: "Other2", director: "Director")
      results = Movie.similar_movies(@movie1.title)
      expect(results).to eq([@movie1.title,@movie2.title])
    end        
  end    

  context 'no other movies by that director' do
    it 'finds no other movies with same director' do
      @movie1 = Movie.create(title: "Other1", director: "Director")
      @movie2 = Movie.create(title: "Other2", director: "Director2")
      results = Movie.similar_movies(@movie1.title)
      expect(results).not_to eq([@movie1.title,@movie2.title])
    end
  end
end 