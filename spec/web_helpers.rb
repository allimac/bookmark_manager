def add_link(tag = 'dev')
  fill_in('title', with: 'Makers Academy')
  fill_in('url', with: 'www.makersacademy.com')
  fill_in('tag', with: tag)
  click_button 'Save'
end

def register(name: 'Giamir', email: 'giamir.buoncristiani@gmail.com',
            password: 'giamir90', pass_confirm: 'giamir90')
  visit('/register')
  fill_in('name', with: name)
  fill_in('email', with: email)
  fill_in('password', with: password)
  fill_in('password_confirmation', with: pass_confirm)
  click_button('Register')
end
