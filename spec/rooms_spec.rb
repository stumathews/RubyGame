require 'room_builder'
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
  
  example 'rooms neighours are correct' do
    for r in 0..ROWS-1 do
      for c in 0..COLS-1 do
        room = subject[r*COLS+c]
        top = room.neighbours[:top]
        bottom = room.neighbours[:bottom]
        left = room.neighbours[:left]
        right = room.neighbours[:right]
        if top
          expect(top.number).to eq(room.number - COLS)
        end
        if bottom
          expect(bottom.number).to eq(room.number + COLS)
        end
        if left
          expect(left.number).to eq(room.number - 1)
        end
        if right
          expect(right.number).to eq(room.number + 1)
        end
      end
    end
  end

  example 'neighbours should not be set to out of bounds values' do
    for r in [0, ROWS-1] do
      for c in [0, COLS-1] do
        room = subject[r*COLS+c]
        if room.col == 0
          expect(room.neighbours[:left]).to eq(nil)
        end
        if room.row == 0
          expect(room.neighbours[:top]).to eq(nil)
        end
        if room.col == COLS-1
          expect(room.neighbours[:right]).to eq(nil)
        end
        if room.row == ROWS-1
          expect(room.neighbours[:bottom]).to eq(nil)
        end

      end
    end
    
  end

end
