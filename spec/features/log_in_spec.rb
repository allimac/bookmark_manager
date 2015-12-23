feature 'Logging in' do

  let(:name) { 'Giamir' }
  let(:email) { 'giamir@gmail.com' }
  let(:password) { 'giamm' }

  scenario 'if a user is registered' do
    register(email: email, name: name, password: password, pass_confirm: password)
    visit '/login'
    fill_in('email', with: email)
    fill_in('password', with: password)
    click_button('Login')
    expect(page).to have_content 'Welcome back Giamir!'
  end
end
