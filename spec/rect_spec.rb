require 'rect'
require 'set'

# Also known as an ''Example' Group
RSpec.describe 'a rect' do
  # Overall test subject
  subject { make_rect  }

  # Easy test subject creator
  def make_rect()
    Rect.new(0,0,10,10)
  end

  example 'Internal points a, b, c, d are correct set correctly' do
    expect(subject.a.x).to eq(subject.x)
    expect(subject.a.y).to eq(subject.y)
    expect(subject.b.x).to eq(subject.a.x + subject.w)
    expect(subject.b.y).to eq(subject.a.y)
    expect(subject.d.x).to eq(subject.b.x)
    expect(subject.d.y).to eq(subject.b.y + subject.h)
    expect(subject.c.x).to eq(subject.a.x)
    expect(subject.c.y).to eq(subject.a.y + subject.h)
  end


  # Logical grouping of tests
  context 'Equality tests:' do
    let(:other) { make_rect  }

    # Note each example is an instance of the Example Group class
    # which is dynamically generated
    example 'is hash equal to itself' do

      raise unless Set.new([subject, other]).size == 1

    end

    example 'is equal to itself' do
      expect(subject).to eq(other)
    end
  end
end



