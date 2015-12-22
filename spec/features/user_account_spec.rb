feature 'Registering' do

  scenario 'user creates a new account' do
    start_registration
    fill_in('password_confirmation', with: 'giamir90')
    expect { click_button('Register') }.to change(User, :count).by(1)
    expect(User.last.email).to eq 'giamir.buoncristiani@gmail.com'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome Giamir!'
  end

  scenario 'if email isn\'t enetered, user can\'t register' do
    visit('/register')
    fill_in('name', with: 'Giamir')
    fill_in('password', with: 'giamir90')
    fill_in('password_confirmation', with: 'giamir90')
    expect { click_button('Register') }.not_to change(User, :count)
    expect(page).to have_content 'Email must not be blank'
    expect(page).to have_selector("input[value='Giamir']")
    expect(current_path).not_to eq '/links'
  end

  scenario 'if the password is mismatching, no user are created' do
    start_registration
    fill_in('password_confirmation', with: 'giamir80')
    expect { click_button('Register') }.not_to change(User, :count)
    expect(current_path).not_to eq '/links'
  end

  scenario 'if the password is mismatching, an error is displayed and
    email and name are still filled in' do
    start_registration
    fill_in('password_confirmation', with: 'giamir80')
    click_button('Register')
  end
end
