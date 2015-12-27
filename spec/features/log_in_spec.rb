feature 'Logging in' do

  let(:name) { 'Giamir' }

  scenario 'if a user is registered' do
    register(name: name)
    log_out
    log_in
    expect(page).to have_content 'Welcome back Giamir!'
  end
end
