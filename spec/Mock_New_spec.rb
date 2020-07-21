require 'rspec'
require 'date'

class InjectedDependency
  def getName
    return 'InjectedDependency'
  end

  def getNamePlus(extra)
    return "#{getName} #{extra}"
  end

end

class UserService
  def initialize()
    @injectedDependency = InjectedDependency.new
  end
  def sayHelloIAmAlive
    return 'Hello my name is ' +  @injectedDependency.getName + ', and I am alive!'
  end


  def sayHelloIAmAlivePlus(more)
    return 'Hello my name is ' +  @injectedDependency.getNamePlus(more) + ', and I am alive!'
  end
end


RSpec.describe 'CLassWithInjectedDependencies' do
  describe 'NoMocks' do

    it 'no params' do
      # given

      # when
      unitUnderTest = UserService.new()
      actual = unitUnderTest.sayHelloIAmAlive

      # then
      expect(actual).to eq('Hello my name is InjectedDependency, and I am alive!')
    end

    it 'with params' do
      # given
      dependency = InjectedDependency.new

      # when
      unitUnderTest = UserService.new()
      moreString = 'someMore'
      actual = unitUnderTest.sayHelloIAmAlivePlus(moreString)

      # then
      expect(actual).to eq("Hello my name is InjectedDependency #{moreString}, and I am alive!")
    end
  end

  describe 'NewMocked' do
    it 'no params' do
      # given

      dependency = double("someThingy")
      expect(dependency).to receive(:getName).and_return('Some Freaky Mock')
      allow(InjectedDependency).to receive(:new).and_return(dependency)

      # when
      unitUnderTest = UserService.new()
      actual = unitUnderTest.sayHelloIAmAlive

      # then
      expect(actual).to eq('Hello my name is Some Freaky Mock, and I am alive!')
    end

    it 'with params' do
      # given
      dependency = double("someThingy")
      extraStringParam = 'someExtra'
      getNamePlusResponse = 'Some Freaky Mock'
      expect(dependency).to(receive(:getNamePlus).with(extraStringParam)).and_return(getNamePlusResponse)
      allow(InjectedDependency).to receive(:new).and_return(dependency)

      # when
      unitUnderTest = UserService.new()
      actual = unitUnderTest.sayHelloIAmAlivePlus(extraStringParam)

      # then
      expect(actual).to eq("Hello my name is #{getNamePlusResponse}, and I am alive!")
    end
  end
end
