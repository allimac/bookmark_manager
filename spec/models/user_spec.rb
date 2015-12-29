require_relative '../../app/models/user'

describe User do

  let!(:user) do
    described_class.new(email: 'giamir.buoncristiani@gmail.com',
    password_confirmation: 'giamir90')
  end

  before do
    user.password = 'giamir90'
    user.save
  end

  it 'should return the user if the user is autenticated' do
    expect(User.authenticate('giamir.buoncristiani@gmail.com', 'giamir90')).to eq user
  end

  it 'saves a new token when user generates a token' do
    expect{user.generate_token}.to change {user.token}
  end

  it 'saves the time when a token is created' do
    Time.freeze do
      user.generate_token
      expect(user.token_time).to eq Time.now
    end
  end

end
