feature 'Logging out' do

  scenario 'if a user is registered' do
    register
    log_out
    expect(page).to have_content 'Goodbye!'
    expect(current_path).to eq '/links'
  end
end
