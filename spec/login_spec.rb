RSpec.describe 'LoginTest' do

  before(:all) do
    @login_repo_mock = double('login_repo_mock')
    @login_factory_mock = double('login_factory_mock')
    @user_repo_mock = double('user_repo_mock')
    @login_service = LoginService.new(@user_repo_mock, @login_factory_mock, @login_repo_mock)
  end

  it 'when called correctly' do
    # given
    login_name = 'someName'
    user = double('user_mock')
    expected_login = double('login_mock')

    expect(@user_repo_mock).to(receive(:get).with(login_name)).and_return(user)
    expect(@login_factory_mock).to(receive(:create).with(user)).and_return(expected_login)
    expect(@login_repo_mock).to(receive(:save).with(expected_login)).and_return(expected_login)

    # when
    actual = @login_service.login(login_name)

    # then
    expect(actual).to eq(expected_login)
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
    def initialize(user_repo, login_factory, login_repo)
      @user_repo = user_repo
      @login_factory = login_factory
      @login_repo = login_repo
    end

    def login(login_name)
      user = @user_repo.get(login_name)
      login = @login_factory.create(user)
      @login_repo.save(login)
    end
  end