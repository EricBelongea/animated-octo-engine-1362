require "rails_helper"

RSpec.describe Studio, type: :model do
  before :each do
    @studio1 = Studio.create!(name: "Universal Studios", location: "Hollywood")
    @studio2 = Studio.create!(name: "Disney", location: "Orlando")
    @studio3 = Studio.create!(name: "Underground", location: "New York")

    @movie1 = Movie.create!(title: "Toy Story", creation_year: "1995", genre: "animation", studio: @studio1)
    @movie2 = Movie.create!(title: "Django", creation_year: "2019", genre: "comedy", studio: @studio3)
    @movie3 = Movie.create!(title: "Mission Impossible", creation_year: "2015", genre: "action", studio: @studio1)
    @movie4 = Movie.create!(title: "Barbie", creation_year: "2023", genre: "comedy", studio: @studio1)
    @movie5 = Movie.create!(title: "Oppenheimer", creation_year: "2023", genre: "documentary", studio: @studio1)
    @movie6 = Movie.create!(title: "frozen", creation_year: "2012", genre: "animation", studio: @studio2)

    @actor1 = Actor.create!(name: "Meryl Streep", age: 73)
    @actor2 = Actor.create!(name: "Tom Hanks", age: 64)
    @actor3 = Actor.create!(name: "Morgan Freeman", age: 82)
    @actor4 = Actor.create!(name: "Jack Black", age: 56)
    @actor5 = Actor.create!(name: "Margot Robbie", age: 33)
  end

  describe "relationships" do
    it {should have_many :movies}
  end

  it "studio_movies" do
    expect(@studio1.studio_movies).to eq([@movie1.title, @movie3.title, @movie4.title, @movie5.title])
    expect(@studio1.studio_movies).to_not eq([@movie2.title])
  end

  it "contributing_actors" do
    @movie4.actors << @actor5
    @movie4.actors << @actor4
    @movie4.actors << @actor3

    expect(@studio1.contributing_actors).to eq([@actor4.name, @actor5.name, @actor3.name])
    
    @movie5.actors << @actor2
    @movie5.actors << @actor1

    expect(@studio1.contributing_actors).to eq([@actor4.name, @actor5.name, @actor1.name, @actor3.name, @actor2.name])
  end
end
