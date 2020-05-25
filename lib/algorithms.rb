module Algorithms
class Prims
  def self.on(maze, start_at)
    room_queue = []
    room_queue << start_at
    while room_queue.any?
      # puts "room_queue count: #{room_queue.size}"
      room = room_queue.sample
      # puts "Processing next room -> #{room}"

      available_neighbours = room.neighbours.select {|k,v| v.links.empty? }
      if available_neighbours.any?
        # puts "room #{room.number} as empty links"
        # puts "Found neighbours: #{available_neighbours.size} in room #{room.number}"
        
        available_neighbours.keys.each { |k| puts k }
        side = available_neighbours.keys.sample
        neighbour = available_neighbours[side]

        # puts "preparing to link room #{room.number} its neighbour on side #{side} which is room  #{neighbour.number}"
        room.link_with(side)
        case side
          when :top
            neighbour.link_with(:bottom)
          when :bottom
            neighbour.link_with(:top)
          when :left
            neighbour.link_with(:righ)
          when :right
            neighbour.link_with(:left)
        end

        room_queue << neighbour 
      else
        # puts "No neighbours, removing from processing queue"
        room_queue.delete(room)
      end
    end

    #check
    maze.each { |r| 
      puts "room #{r.number} has #{r.neighbours.size} neighbours and #{r.links.size} links configured" 
      puts "links"
      r.links.each {|l| puts l}
    }

    #return the maze
    maze
  end
end
end

