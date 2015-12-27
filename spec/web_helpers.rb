def add_link(tag = 'dev')
  fill_in('title', with: 'Makers Academy')
  fill_in('url', with: 'www.makersacademy.com')
  fill_in('tag', with: tag)
  click_button 'Save'
end
