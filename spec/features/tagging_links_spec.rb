# As a time-pressed user
# So that I can organise my many links into different
# categories for ease of search
# I would like to tag links in my bookmark manager
feature 'Tagging links' do
  scenario 'user adds a tag when creating new link' do
    visit '/links/new'
    add_link
    within 'ul#links' do
      expect(page).to have_content('dev')
    end
  end
end
