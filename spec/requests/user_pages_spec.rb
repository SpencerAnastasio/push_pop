require 'spec_helper'

describe "User Pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Index page" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end
    it { should have_title('Users') }
    it { should have_content('Users') }
    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.username)
      end
    end
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }
      it { should have_selector('div.pagination') }
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.username)
        end
      end
    end
    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "Edit page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    describe "edit" do
      it { should have_content("Update Your Profile") }
      it { should have_title("Edit Profile") }
    end
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('short') }
    end
    describe "with valid information" do
      let(:new_username)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Username",     with: new_username
        fill_in "Email (with Gravatar)",        with: new_email
        fill_in "Password",     with: user.password
        fill_in "Password Confirmation", with: user.password
        click_button "Save changes"
      end
      it { should have_title(new_username) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { expect(user.reload.username).to eq new_username }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe "Signup page" do
    let(:heading)    { 'Sign Up' }
    let(:page_title) { 'Sign Up' }
    before { visit signup_path }
    it_should_behave_like "all static pages"
    # it "should have the right links on the signup partial" do
    #   visit signup_path
    #   first('.hero-unit').click_link("Signup")
    #   expect(page).to have_title(full_title(''))
    # end
    describe "Signup" do
      let(:submit) { "Create my account" }
      before { visit signup_path }
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        describe "blank field" do
          before do
            fill_in "Email (with Gravatar)",        with: "user@example.com"
            fill_in "Password",     with: "foobach"
            fill_in "Password Confirmation", with: "foobach"
            click_button submit
          end

          it { should have_title('Sign Up') }
          it { should have_content('blank') }
        end
        describe "invalid field" do
          before do
            fill_in "Username",     with: "Example User"
            fill_in "Email (with Gravatar)",        with: "user@example_com"
            fill_in "Password",     with: "foobach"
            fill_in "Password Confirmation", with: "foobach"
            click_button submit
          end
          it { should have_title('Sign Up') }
          it { should have_content('invalid') }
        end
      end
      describe "with valid information" do
        before do
          fill_in "Username",       with: "Example User"
          fill_in "Email (with Gravatar)",          with: "user@example.com"
          fill_in "Password",       with: "foobar"
          fill_in "Password Confirmation",   with: "foobar"
        end
        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end
        describe "after user submit" do
          before { click_button submit }
          let(:user) { User.find_by(email: 'user@example.com') }
          it { should have_title(user.username) }
        end
        describe "after saving the user" do
          before { click_button submit }
          let(:user) { User.find_by(email: 'user@example.com') }
          it { should have_link('Sign Out') }
          it { should have_title(user.username) }
        end
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email (with Gravatar)",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in to PUSHPOP"
    end
    let!(:p1) { FactoryGirl.create(:playlist, user: user, name: "Foo") }
    let!(:p2) { FactoryGirl.create(:playlist, user: user, name: "Bar") }
    it { should have_content(user.username) }
    it { should have_title(user.username) }
    # it { should have_content(p1.name) }
    # it { should have_content(p2.name) }
    # it { should have_content(user.playlists.count) }
  end

end
