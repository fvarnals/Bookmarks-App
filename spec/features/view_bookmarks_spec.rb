feature 'view bookmarks' do
  scenario 'a user wants to view their list of bookmarks' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'www.stackoverflow.com'
    fill_in 'title', with: 'Coding Forum'
    click_button('Add Bookmark')
    click_button('View Bookmarks')
    expect(page).to have_link('Coding Forum', href: 'www.stackoverflow.com')
  end

end
