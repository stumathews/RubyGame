module Algorithms
class Prims
  def self.on(maze, start_at: maze.sample)
    room_queue = []
    room_queue << start_at
    puts "starting room is #{start_at}"
    while room_queue.any?
      # choose a random room of the ones we know about
      room = room_queue.sample
      puts "current room is #{room}"
      # get that rooms neighbours
      available_neighbours = room&.neighbours&.select {|k,v| v&.links&.empty? }
      if available_neighbours&.any?
        # choose a random neighbour
        neighbour_key = available_neighbours.keys.sample
        # link current room with this neighbour
        room.link(neighbour_key)
        # now let that neighbour be considered next:
        room_queue << available_neighbours[neighbour_key]
      else
        # room has no neighbours - no more looking for its neighbours
        room_queue.delete(room)
      end
    end
    #return the maze
    maze
  end
end
end

