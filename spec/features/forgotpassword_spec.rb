feature 'Recovering and resetting password' do

  let(:email) { 'camilla.colomboserri@gmail.com' }
  let(:password) { 'pass1234' }

  before do
    register(email: email)
    Capybara.reset!
  end

  scenario 'User can see link if he has forgotten his password' do
    visit'/links'
    click_button('Log in')
    click_link('Forgot password?')
    expect(current_path).to eq '/sessions/password_recover'
    expect(page).to have_content 'We\'ll send you instructions to reset your password.'
  end

  scenario 'User can click and create a new token for resetting password' do
    expect { password_recover(email: email) }.to change { User.first(email: email).token }
    expect(page).to have_content 'Instructions to reset your password have been sent via email'
  end


  # scenario 'user uses the link from email to restore password' do
  #   password_recover(email: email)
  #   visit"/sessions/password_reset/?email=#{email}&token=#{User.first(email: email).token}"
  #   expect(page).to have_selector("input[value='#{email}']")
  # end

  # scenario 'user uses the token to reset his password' do
  #   fill_in('password', with: password)
  #   fill_in('confirm_password', password)
  #   click_button('Save password')
  #   expect(page).to have_content 'Your new password has been saved!'
  #   expect(current_path).not_to eq '/links'
  # end
end
