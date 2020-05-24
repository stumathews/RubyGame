require_relative 'room_builder'
RSpec.describe 'Rooms', :aggregate_failures do
  include RoomBuilding
  ROOM_SIZE = 16
  ROWS = 4
  COLS = 4
  subject { 
    create_rooms(rows = ROWS, cols = COLS, room_width = 10, room_height= 10)  
  }

  example 'Correct number of rooms are created' do
    expect(subject.size).to eq(ROOM_SIZE)
  end

  example 'cols start zero based' do
    expect(subject.first.col).to eq(0)
  end
  
  example 'rows start zero based' do
    expect(subject.first.row).to eq(0)
  end

  example 'every row reports consequtive columns' do
    for r in 0..ROWS-1 do
      for c in 0..COLS-1 do
        expect(subject[r*COLS+c].col).to eq(c)
      end
    end
  end

  example 'every row is consequative' do
    for r in 0..ROWS-1 do
      for c in 0..COLS-1 do
        expect(subject[r*COLS+c].row).to eq(r)
      end
    end
  end

end
