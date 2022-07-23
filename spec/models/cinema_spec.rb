require 'rails_helper'

RSpec.describe Cinema, type: :model do
  STRING_LEN_1001 = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"

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

    it "when title more digits, it registration is not possible" do
      new_cinema.title = '123456789012345678901234567890123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when screen time is nil, it registration is not possible" do
      new_cinema.screen_time = nil
      expect(new_cinema).not_to be_valid
    end

    it "when birthplace is nil, it registration is not possible" do
      new_cinema.birthplace = nil
      expect(new_cinema).not_to be_valid
    end

    it "when birthplace more digits, it registration is not possible" do
      new_cinema.birthplace = '123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when movie rating is nil, it registration is not possible" do
      new_cinema.movie_rating = nil
      expect(new_cinema).not_to be_valid
    end

    it "when movie rating more digits, it registration is not possible" do
      new_cinema.movie_rating = '12345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when director is nil, it registration is not possible" do
      new_cinema.director = nil
      expect(new_cinema).not_to be_valid
    end

    it "when director more digits, it registration is not possible" do
      new_cinema.director = '123456789012345678901234567890123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when original is nil, it registration is not possible" do
      new_cinema.original = nil
      expect(new_cinema).not_to be_valid
    end

    it "when original more digits, it registration is not possible" do
      new_cinema.original = '123456789012345678901234567890123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when appearance is nil, it registration is not possible" do
      new_cinema.appearance = nil
      expect(new_cinema).not_to be_valid
    end

    it "when appearance more digits, it registration is not possible" do
      new_cinema.appearance = STRING_LEN_1001
      expect(new_cinema).not_to be_valid
    end

    it "when screenwriter is nil, it registration is not possible" do
      new_cinema.screenwriter = nil
      expect(new_cinema).not_to be_valid
    end

    it "when screenwriter more digits, it registration is not possible" do
      new_cinema.screenwriter = '123456789012345678901234567890123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when distribution is nil, it registration is not possible" do
      new_cinema.distribution = nil
      expect(new_cinema).not_to be_valid
    end

    it "when distribution more digits, it registration is not possible" do
      new_cinema.distribution = '123456789012345678901'
      expect(new_cinema).not_to be_valid
    end

    it "when start date is nil, it registration is not possible" do
      new_cinema.start_date = nil
      expect(new_cinema).not_to be_valid
    end

    it "when story is nil, it registration is not possible" do
      new_cinema.story = nil
      expect(new_cinema).not_to be_valid
    end

    it "when story more digits, it registration is not possible" do
      new_cinema.story = STRING_LEN_1001
      expect(new_cinema).not_to be_valid
    end
  end

  describe '#update' do
    let!(:cinema) { create(:cinema) }
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

    it "when title more digits, it can be not updated" do
      cinema.title = '123456789012345678901234567890123456789012345678901'
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

    it "when birthplace more digits, it can be not updated" do
      cinema.birthplace = '123456789012345678901'
      expect(cinema).not_to be_valid
    end

    it "when movie rating is nil, it can be not updated" do
      cinema.movie_rating = nil
      expect(cinema).not_to be_valid
    end

    it "when movie rating more digits, it can be not updated" do
      cinema.movie_rating = '12345678901'
      expect(cinema).not_to be_valid
    end

    it "when director is nil, it can be not updated" do
      cinema.director = nil
      expect(cinema).not_to be_valid
    end

    it "when director more digits, it can be not updated" do
      cinema.director = '123456789012345678901234567890123456789012345678901'
      expect(cinema).not_to be_valid
    end

    it "when original is nil, it can be not updated" do
      cinema.original = nil
      expect(cinema).not_to be_valid
    end

    it "when original more digits, it can be not updated" do
      cinema.original = '123456789012345678901234567890123456789012345678901'
      expect(cinema).not_to be_valid
    end

    it "when appearance is nil, it can be not updated" do
      cinema.appearance = nil
      expect(cinema).not_to be_valid
    end

    it "when appearance more digits, it can be not updated" do
      cinema.appearance = STRING_LEN_1001
      expect(cinema).not_to be_valid
    end

    it "when screenwriter is nil, it can be not updated" do
      cinema.screenwriter = nil
      expect(cinema).not_to be_valid
    end

    it "when screenwriter more digits, it can be not updated" do
      cinema.screenwriter = '123456789012345678901234567890123456789012345678901'
      expect(cinema).not_to be_valid
    end

    it "when distribution is nil, it can be not updated" do
      cinema.distribution = nil
      expect(cinema).not_to be_valid
    end

    it "when distribution more digits, it can be not updated" do
      cinema.distribution = '123456789012345678901'
      expect(cinema).not_to be_valid
    end

    it "when start date is nil, it can be not updated" do
      cinema.start_date = nil
      expect(cinema).not_to be_valid
    end

    it "when story is nil, it can be not updated" do
      cinema.story = nil
      expect(cinema).not_to be_valid
    end

    it "when story more digits, it can be not updated" do
      cinema.story = STRING_LEN_1001
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
