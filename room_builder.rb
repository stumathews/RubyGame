require_relative 'room'
module RoomBuilding

  def create_rooms(rows, cols, room_width, room_height)
    @rooms = []
    for r in 0..rows - 1
      for c in 0..cols - 1
        start_x = c * room_width
        start_y = r * room_height
        room = Room.new(start_x, start_y, room_width, room_height) 
       # puts "Adding room: #{room}"
        @rooms << room
      end
    end
    for i in 0..@rooms.size
      next_index = i + 1
      prev_index = i - 1
      break if next_index > @rooms.size

      this_row = (i / cols).abs()
      last_col = ((this_row) * cols) -1
      this_col = ((cols * this_row) - i).abs() 
      
      # neighbour's index
      room_above_index = i - cols
      room_below_index = i + cols
      room_left_index = prev_index
      room_right_index = next_index

      room = @rooms[i]
      room.number = i
      room.col = this_col
      room.row = this_row
      
      # possibly remove sides
      can_remove_above = room_above_index > 0
      can_remove_below = room_below_index < @rooms.size
      can_remove_left = this_col -1 >= 1
      can_remove_right = this_col  <= cols
      
      # Set the neighbours
      if can_remove_above
        room.neighbours[:top] = @rooms[room_above_index]
      end
     
      if can_remove_below
        room.neighbours[:bottom] = @rooms[room_below_index]
      end

      if can_remove_left
        room.neighbours[:left] = @rooms[room_left_index]
      end

      if can_remove_right
        room.neighbours[:right] = @rooms[room_right_index]
      end
      
      # report for neighbours
      # puts "   [#{room_above_index}]"
      # puts "[#{room_left_index}][#{i}][#{room_right_index}]  row=#{this_row} col=#{this_col}"
      # puts "   [#{room_below_index}]"
    end
    # puts "There are #{@rooms.size} rooms"
    @rooms
  end
end

