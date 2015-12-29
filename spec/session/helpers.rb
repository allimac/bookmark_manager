module SessionHelpers

  EMAIL = 'giamir.buoncristiani@gmail.com'
  PASSWORD = 'giamir90'

  def register(email: EMAIL, password: PASSWORD, pass_confirm: PASSWORD)
    visit('/links')
    click_button('Register')
    fill_in('email', with: email)
    fill_in('password', with: password)
    fill_in('password_confirmation', with: pass_confirm)
    click_button('Register')
  end


  def log_in(email: EMAIL, password: PASSWORD)
    visit('/links')
    click_button('Log in')
    fill_in('email', with: email)
    fill_in('password', with: password)
    click_button('Login')
  end

  def log_out
    click_button('Logout')
  end

  def password_recover(email: EMAIL)
    visit'/sessions/password_recover'
    fill_in('email', with: email)
    click_button('Reset my password')
  end

end
