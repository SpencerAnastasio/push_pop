require 'spec_helper'

describe "Playlist pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  describe "playlist creation" do
    before { visit new_playlist_path }
    describe "with invalid information" do
      it "should not create a playlist" do
        expect { click_link "Create Playlist" }.not_to change(Playlist, :count)
      end
      describe "error messages" do
        before { click_button "Create Playlist" }
        it { should have_content('blank') }
      end
    end
    describe "with valid information" do
      before do
        fill_in "Playlist name", with: "Lorem Ipsum"
      end
      it "should create a playlist" do
        expect { click_button "Create Playlist" }.to change(Playlist, :count).by(1)
      end
    end
  end
end
