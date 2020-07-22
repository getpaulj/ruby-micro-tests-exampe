require 'rspec'
require 'date'

RSpec.describe 'CLassWithInjectedDependencies' do
  describe 'CLassWithInjectedDependencies' do

    it 'no params' do
      # given
      dependency = InjectedDependency.new

      # when
      unitUnderTest = CLassWithInjectedDependencies.new(dependency)
      actual = unitUnderTest.sayHelloIAmAlive

      # then
      expect(actual).to eq('Hello my name is InjectedDependency, and I am alive!')
    end

    it 'with params' do
      # given
      dependency = InjectedDependency.new

      # when
      unitUnderTest = CLassWithInjectedDependencies.new(dependency)
      moreString = 'someMore'
      actual = unitUnderTest.sayHelloIAmAlivePlus(moreString)

      # then
      expect(actual).to eq("Hello my name is InjectedDependency #{moreString}, and I am alive!")
    end
  end

  describe 'CLassWithInjectedDependencies' do
    it 'no params' do
      # given
      dependency = double("someThingy")
      expect(dependency).to receive(:getName).and_return('Some Freaky Mock')

      # when
      unitUnderTest = CLassWithInjectedDependencies.new(dependency)
      actual = unitUnderTest.sayHelloIAmAlive

      # then
      expect(actual).to eq('Hello my name is Some Freaky Mock, and I am alive!')
    end

    it 'with params' do
      # given
      extraStringParam = 'someExtra'
      dependency = double("someThingy")
      getNamePlusResponse = 'Some Freaky Mock'
      expect(dependency).to(receive(:getNamePlus).with(extraStringParam)).and_return(getNamePlusResponse)

      # when
      unitUnderTest = CLassWithInjectedDependencies.new(dependency)
      actual = unitUnderTest.sayHelloIAmAlivePlus(extraStringParam)

      # then
      expect(actual).to eq("Hello my name is #{getNamePlusResponse}, and I am alive!")
    end
  end
end



class InjectedDependency
  def getName
    return 'InjectedDependency'
  end

  def getNamePlus(extra)
    return "#{getName} #{extra}"
  end

end

class CLassWithInjectedDependencies
  def initialize(dependency)
    @injectedDependency = dependency
  end
  def sayHelloIAmAlive
    return 'Hello my name is ' +  @injectedDependency.getName + ', and I am alive!'
  end

  def sayHelloIAmAlivePlus(more)
    return 'Hello my name is ' +  @injectedDependency.getNamePlus(more) + ', and I am alive!'
  end
end
