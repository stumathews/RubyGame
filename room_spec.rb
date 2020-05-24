require_relative 'room'

# Room Spec confidence tests

RSpec.describe 'a room' do
  it 'sets its number correctly' do
    room = Room.new(0,0,0,0)
    room.set_room_number(25)
    raise unless room.number == 25
  end

end

