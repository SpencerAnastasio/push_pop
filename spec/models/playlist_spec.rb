require 'spec_helper'

describe Playlist do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @playlist = user.playlists.build(name: "Lorem Ipsum", keycode: "loremipsum")
    # @user = User.new(username: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @playlist }

  it { should respond_to(:name) }
  it { should respond_to(:keycode) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should be_valid }
  describe "when user_id is not present" do
    before { @playlist.user_id = nil }
    it { should_not be_valid }
  end
  describe "with blank name" do
    before { @playlist.name = " " }
    it { should_not be_valid }
  end
  describe "with blank keycode" do
    before { @playlist.keycode = " " }
    it { should be_valid }
  end
  describe "with name that is too long" do
    before { @playlist.name = "a" * 51 }
    it { should_not be_valid }
  end
  describe "with keycode that is too long" do
    before { @playlist.keycode = "a" * 21 }
    it { should_not be_valid }
  end
end
