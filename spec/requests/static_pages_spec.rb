require 'spec_helper'

describe "Static Pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'PUSHPOP' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
    it "should have the right links on the home partial" do
      visit root_path
      click_link("PUSHPOP")
      expect(page).to have_title(full_title(''))
      first('.hero-unit').click_link "Sign In"
      expect(page).to have_title(full_title('Sign In'))
    end
  end

  describe "About page" do
    before { visit about_path }

    let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
    it "should have the right links on the home partial" do
      visit about_path
      first('.hero-unit').click_link("PUSHPOP")
      expect(page).to have_title(full_title(''))
    end
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
    it "should have the right links on the home partial" do
      visit contact_path
      first('.hero-unit').click_link("PUSHPOP")
      expect(page).to have_title(full_title(''))
    end
  end

  describe "Privacy page" do
    before { visit privacy_path }
    let(:heading)    { 'Privacy' }
    let(:page_title) { 'Privacy' }

    it_should_behave_like "all static pages"
  end

  describe "Terms page" do
    before { visit terms_path }
    let(:heading)    { 'Terms' }
    let(:page_title) { 'Terms' }

    it_should_behave_like "all static pages"
  end

  describe "Footer" do
    it "should have the right links on the footer partial" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title('About'))
      click_link "Privacy"
      expect(page).to have_title(full_title('Privacy'))
      click_link "Contact"
      expect(page).to have_title(full_title('Contact'))
      click_link "Terms"
      expect(page).to have_title(full_title('Terms'))
    end
  end

  describe "Header" do
    it "should have the right links on the header partial" do
      visit about_path
      click_link "Sign In"
      expect(page).to have_title(full_title('Sign In'))
      first('.container').click_link("PUSHPOP")
      expect(page).to have_title(full_title(''))
      # click_link "SoundSearch"
      # expect(page).to have_title(full_title('Search'))
    end
  end

end
