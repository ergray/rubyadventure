def prompt
  print "\n> "
  input = $stdin.gets.chomp
  return input
end

def parse_input(string)
  result = /([a-z]+) ([a-z]+)/.match(string)
  return result[2]
end

def game

  playerInventory = []
  playerLocation = ""
  validExits = ['one']
  thisRoom = []

  puts """
  Welcome to my Ruby text adventure!
  Please type in 'start' to begin, or
  'quit' to exit the application. Type
  in 'help' for a list of commands.

  Thanks for playing!
  """

  while true
    decision = prompt

    if decision == "start"
      playerLocation = 0
      thisRoom = show_room(0)
      # start
      puts thisRoom[2]
      validExits = thisRoom[1]
    elsif decision == "quit"
      exit(0)
    elsif decision == 'help'
      help
    elsif decision.include? 'move'
      direction = parse_input(decision)
      movement = validExits[move(direction)]
      if movement != nil
         thisRoom = show_room(movement)
         puts thisRoom[2]
         validExits = thisRoom[1]
      else
        puts "Sorry, but that's not somewhere you can go."
      end
    else
      puts "Please enter start to begin the game or quit to exit."
    end
  end
end

def move(direction)
  compass = ['north', 'east', 'south', 'west', 'up', 'down']
  return compass.index(direction)
end

def help
  puts """
  Here are a list of commands for the game:

  start: Begin the game
  quit:  Exit the game
  move:  Move in a valid direction
  get:   Retrieve item from room
  look:  Look at the room
  """
end

def show_room(roomNumber)
   rooms = [
  [['sword', 'shield'], [1, nil, nil, nil, nil, nil], "You are standing in the entrance of a dark cave.\nThe mouth of this cave is only barely taller than\nyou are and leads into a vast darkness."],
  [[], [nil, 4, 0, 3, nil, nil], "Here is the next room. It strangely\n looks like an office lobby. A woman\n with a nameplate which reads 'Jessica' \nis looking at you."]
  ]
  return rooms[roomNumber]
end


game