module Algorithms
class Prims

  # Visits room that don't have any neighbours yet and links them
  def self.on(maze, start_at)
    room_queue = []
    room_queue << start_at
    while room_queue.any?
      room = room_queue.sample
      available_neighbours = room.neighbours.select {|k,v| v.links.empty? }
      if available_neighbours.any?
        side = available_neighbours.keys.sample
        neighbour = available_neighbours[side]
        room.link_with(side)
        case side
          when :top
            neighbour.link_with(:bottom)
          when :bottom
            neighbour.link_with(:top)
          when :left
            neighbour.link_with(:right)
          when :right
            neighbour.link_with(:left)
        end

        room_queue << neighbour 
      else
        room_queue.delete(room)
      end
    end

    # print_links(maze)

    # return the maze
    maze
  end

  def self.print_links(maze)
    maze.each { |r| 
      puts "room #{r.number} has #{r.neighbours.size} neighbours and #{r.links.size} links configured" 
      puts "links"
      r.links.each {|l| puts l}
    }

  end



end

class Maze
  # Solves the maze by visiting every room from the starting point
  # to the ending point
  def self.solve(rooms, player_room_n, exit_room_n)
    queue = []
    queue << rooms[player_room_n]
    found = player_room_n == exit_room_n
    while queue.any? && !found
      room = queue.sample
      room.visit
      found = room.number == exit_room_n
      queue += room.links.map { |k,v| v } if !found
      queue.delete(room) 
    end 
    found    
  end
end

end

