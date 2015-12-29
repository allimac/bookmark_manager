feature 'Logging in' do

  let(:email) { 'giammo@email.com' }

  scenario 'if a user is registered' do
    register(email: email)
    log_out
    log_in(email: email)
    expect(page).to have_content "Welcome back #{email}!"
  end
end
