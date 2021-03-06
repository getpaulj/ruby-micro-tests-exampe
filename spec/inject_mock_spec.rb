require 'rspec'
require 'date'

RSpec.describe 'CLassWithInjectedDependencies' do

    it 'no params' do
      # given
      dependency = double("someThingy")
      someFreakyMockStr = 'Some Freaky Mock'
      expect(dependency).to receive(:getName).and_return(someFreakyMockStr)

      # when
      unitUnderTest = CLassWithInjectedDependencies.new(dependency)
      actual = unitUnderTest.sayHelloIAmAlive

      # then
      expect(actual).to eq("Hello my name is #{someFreakyMockStr}, and I am alive!")
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
