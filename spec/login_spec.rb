RSpec.describe 'LoginTest' do

  before(:each) do
    @login_repo_mock = double('login_repo_mock')
    @login_factory_mock = double('login_factory_mock')
    @user_repo_mock = double('user_repo_mock')
    @password_validator_mock = double('password_validator_mock')

    @login_service = LoginService.new(@user_repo_mock, @login_factory_mock, @login_repo_mock, @password_validator_mock) #injection
  end

  it 'valid login' do
    # given
    login_name = 'someName'
    password = 'password'
    user = double('user_mock')
    expected_login = double('login_mock')

    expect(@user_repo_mock).to(receive(:get).with(login_name)).and_return(user)
    expect(@login_factory_mock).to(receive(:create).with(user)).and_return(expected_login)
    expect(@login_repo_mock).to(receive(:save).with(expected_login)).and_return(expected_login)
    expect(@password_validator_mock).to(receive(:validate).with(login_name, password)).and_return(true)

    # when
    actual = @login_service.login(login_name, password)

    # then
    expect(actual).to eq(expected_login)
  end

  it 'invalid password' do
    # given
    login_name = 'someName'
    password = 'somePassword'
    user = double('user_mock')
    expect(@user_repo_mock).to(receive(:get).with(login_name)).and_return(user)
    expect(@password_validator_mock).to(receive(:validate).with(login_name, password)).and_return(false)

    # when
    actual = @login_service.login(login_name, password)

    # then
    expect(actual).to eq(nil)
  end

end


# IMPLEMENTATION

  class User

  end

  class UserRepository
    def get
      throw new Exception('You need to write some mode code')
    end

    def save(user)
      throw new Exception('You need to write some mode code')
    end
  end

  class Login

  end

  class LoginRepository
    def get
      throw new Exception('You need to write some mode code')
    end

    def save(user)
      throw new Exception('You need to write some mode code')
    end
  end

  class LoginFactory
    def create(user)
      throw new Exception('You need to write some mode code')
    end
  end

  class LoginService
    def initialize(user_repo, login_factory, login_repo, password_validator)
      @user_repo = user_repo
      @login_factory = login_factory
      @login_repo = login_repo
      @password_validator = password_validator
    end

    def login(login_name, password)
      user = @user_repo.get(login_name)

      valid_password =  @password_validator.validate(login_name, password)
      if !valid_password
        return nil;
      end

      login = @login_factory.create(user)
      @login_repo.save(login)
    end
  end