# Generate a maze by linking up rooms
module Algorithms
class Prims
  def self.on(maze, start_at: maze.sample)
    room_queue = []
    room_queue << start_at
    while room_queue.any?
      # choose a random room of the ones we know about
      room = room_queue.sample
      # get that rooms neighbours
      available_neighbours = room.neighbours.select {|v| v != nil }
      if available_neighbours.any?
        # choose a random neighbour
        neighbour = available_neighbours.sample
        # link current room with this neighbour
        room.link(neighbour)
        # now let that neighbour be considered next:
        room_queue << neighbour
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

