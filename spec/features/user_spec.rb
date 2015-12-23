
describe 'User autentication' do
  it 'should return true if the user is autenticated' do
    user = User.new(name: 'Giamir', email: 'giamir.buoncristiani@gmail.com',
                password_confirmation: 'giamir90')
    user.password = 'giamir90'
    expect(user.autenticate?('giamir90')).to eq true
  end
end
