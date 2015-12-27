module SessionHelpers

  def register(name: 'Giamir', email: 'giamir.buoncristiani@gmail.com',
              password: 'giamir90', pass_confirm: 'giamir90')
    visit('/links')
    click_button('Register')
    fill_in('name', with: name)
    fill_in('email', with: email)
    fill_in('password', with: password)
    fill_in('password_confirmation', with: pass_confirm)
    click_button('Register')
  end


  def log_in(email: 'giamir.buoncristiani@gmail.com',
              password: 'giamir90')
    visit('/links')
    click_button('Log in')
    fill_in('email', with: email)
    fill_in('password', with: password)
    click_button('Login')
  end

  def log_out
    click_button('Logout')
  end

end
