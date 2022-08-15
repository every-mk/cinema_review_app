require 'rails_helper'

RSpec.describe Cinema, type: :model do
  describe '#create' do
    let!(:cinema) { create(:cinema) }
    let(:new_cinema) { build(:cinema, title: "new_title") }
    let(:duplicate_title_cinema) { build(:cinema, title: cinema.title) }

    it "when cinema registration, it registration is possible" do
      expect(new_cinema).to be_valid
    end

    it "when title is nil, it registration is not possible" do
      new_cinema.title = nil
      expect(new_cinema).not_to be_valid
    end

    it "when duplicate title, it registration is not possible" do
      expect(duplicate_title_cinema).not_to be_valid
    end

    it "when screen time is nil, it registration is not possible" do
      new_cinema.screen_time = nil
      expect(new_cinema).not_to be_valid
    end

    it "when birthplace is nil, it registration is not possible" do
      new_cinema.birthplace = nil
      expect(new_cinema).not_to be_valid
    end

    it "when movie rating is nil, it registration is not possible" do
      new_cinema.movie_rating = nil
      expect(new_cinema).not_to be_valid
    end

    it "when director is nil, it registration is not possible" do
      new_cinema.director = nil
      expect(new_cinema).not_to be_valid
    end

    it "when original is nil, it registration is not possible" do
      new_cinema.original = nil
      expect(new_cinema).not_to be_valid
    end

    it "when appearance is nil, it registration is not possible" do
      new_cinema.appearance = nil
      expect(new_cinema).not_to be_valid
    end

    it "when screenwriter is nil, it registration is not possible" do
      new_cinema.screenwriter = nil
      expect(new_cinema).not_to be_valid
    end

    it "when distribution is nil, it registration is not possible" do
      new_cinema.distribution = nil
      expect(new_cinema).not_to be_valid
    end

    it "when start date is nil, it registration is not possible" do
      new_cinema.start_date = nil
      expect(new_cinema).not_to be_valid
    end

    it "when end date is nil, it registration is not possible" do
      new_cinema.end_date = nil
      expect(new_cinema).not_to be_valid
    end

    it "when story is nil, it registration is not possible" do
      new_cinema.story = nil
      expect(new_cinema).not_to be_valid
    end
  end

  describe '#update' do
    let(:cinema) { create(:cinema) }
    let!(:cinema1) { create(:cinema, title: "title_cinema1") }

    it "when have not change, it can be updated" do
      expect(cinema).to be_valid
    end

    it "when title is nil, it can be not updated" do
      cinema.title = nil
      expect(cinema).not_to be_valid
    end

    it "when duplicate title, it can be not updated" do
      cinema.title = cinema1.title
      expect(cinema).not_to be_valid
    end

    it "when screen time is nil, it can be not updated" do
      cinema.screen_time = nil
      expect(cinema).not_to be_valid
    end

    it "when birthplace is nil, it can be not updated" do
      cinema.birthplace = nil
      expect(cinema).not_to be_valid
    end

    it "when movie rating is nil, it can be not updated" do
      cinema.movie_rating = nil
      expect(cinema).not_to be_valid
    end

    it "when director is nil, it can be not updated" do
      cinema.director = nil
      expect(cinema).not_to be_valid
    end

    it "when original is nil, it can be not updated" do
      cinema.original = nil
      expect(cinema).not_to be_valid
    end

    it "when appearance is nil, it can be not updated" do
      cinema.appearance = nil
      expect(cinema).not_to be_valid
    end

    it "when screenwriter is nil, it can be not updated" do
      cinema.screenwriter = nil
      expect(cinema).not_to be_valid
    end

    it "when distribution is nil, it can be not updated" do
      cinema.distribution = nil
      expect(cinema).not_to be_valid
    end

    it "when start date is nil, it can be not updated" do
      cinema.start_date = nil
      expect(cinema).not_to be_valid
    end

    it "when end date is nil, it can be not updated" do
      cinema.end_date = nil
      expect(cinema).not_to be_valid
    end

    it "when story is nil, it can be not updated" do
      cinema.story = nil
      expect(cinema).not_to be_valid
    end
  end

  describe '#destroy' do
    let(:cinema) { create(:cinema) }

    it "when cinema destory, deleted" do
      cinema.destroy
      expect(Cinema.exists?(id: cinema.id)).to be false
    end
  end
end
