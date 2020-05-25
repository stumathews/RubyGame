require_relative 'room'
module RoomBuilding

  # Create rows x cols of rooms.
  def create_rooms(rows, cols, room_width, room_height)
    @rooms = []
    
    # rows and cols are zero-indexed
    for r in 0..rows - 1
      for c in 0..cols - 1
        start_x = c * room_width
        start_y = r * room_height
        room = Room.new(start_x, start_y, room_width, room_height) 
       # puts "Adding room: #{room}"
        @rooms << room
      end
    end

    # Configure rooms
    for i in 0..@rooms.size
      next_index = i + 1
      prev_index = i - 1
      break if next_index > @rooms.size

      this_row = (i / cols).abs()
      this_col = ((cols * this_row) - i).abs() 
      
      # neighbour's indexes
      room_above_index = i - cols
      room_below_index = i + cols
      room_left_index = prev_index
      room_right_index = next_index

      room = @rooms[i]
      room.number = i
      room.col = this_col
      room.row = this_row
      
      neighbour_above = room_above_index > 0
      neighbour_below = room_below_index < @rooms.size
      neighbour_left = this_col  > 0
      neighbour_right = this_col < cols-1
      
      # Set the room's neighbours to the actual rooms that represent the neighbours
      if neighbour_above
        room.neighbours[:top] = @rooms[room_above_index]
      end
     
      if neighbour_below
        room.neighbours[:bottom] = @rooms[room_below_index]
      end

      if neighbour_left
        room.neighbours[:left] = @rooms[room_left_index]
      end

      if neighbour_right
        room.neighbours[:right] = @rooms[room_right_index]
      end
    end
    @rooms
  end
end

