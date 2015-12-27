feature 'Registering' do

  scenario 'user creates a new account' do
    expect { register }.to change(User, :count).by(1)
    expect(User.last.email).to eq 'giamir.buoncristiani@gmail.com'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome Giamir!'
  end

  scenario 'if email isn\'t enetered, user can\'t register' do
    expect { register(email: nil) }.not_to change(User, :count)
    expect(page).to have_selector("input[value='Giamir']")
    expect(current_path).not_to eq '/links'
  end

  scenario 'if email is already taken, user is warned' do
    register
    log_out
    register
    expect(page).to have_content('Email is already taken')
    expect(current_path).not_to eq '/links'
  end

  scenario 'if password confrim is wrong, no user is created; input fields name
            and email are still populated' do
    expect { register(pass_confirm: 'giamir80') }.not_to change(User, :count)
    expect(page).to have_selector("input[value='giamir.buoncristiani@gmail.com']")
    expect(page).to have_selector("input[value='Giamir']")
    expect(current_path).not_to eq '/links'
  end

end
