def fill_in_form_and_save(tag = 'dev')
  fill_in('title', with: 'Makers Academy')
  fill_in('url', with: 'www.makersacademy.com')
  fill_in('tag', with: tag)
  click_button 'Save'
end

def start_registration
  visit('/register')
  fill_in('name', with: 'Giamir')
  fill_in('email', with: 'giamir.buoncristiani@gmail.com')
  fill_in('password', with: 'giamir90')
end
