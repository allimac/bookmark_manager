require_relative '../../app/models/user'

describe User do

  let!(:user) do
    described_class.new(name: 'Giamir', email: 'giamir.buoncristiani@gmail.com',
    password_confirmation: 'giamir90')
  end

  before do
    user.password = 'giamir90'
    user.save
  end

  it 'should return the user if the user is autenticated' do
    expect(User.authenticate('giamir.buoncristiani@gmail.com', 'giamir90')).to eq user
  end

end
