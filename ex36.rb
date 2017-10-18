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
  roomObjects = []
  validExits = []
  thisRoom = []
  gameStarted = false

  puts """
  Welcome to my Ruby text adventure!
  Please type in 'start' to begin, or
  'quit' to exit the application. Type
  in 'help' for a list of commands.

  Thanks for playing!
  """

  while true
    decision = prompt

    if decision == "start" && gameStarted == false
      gameStarted = true
      playerLocation = 0
      thisRoom = show_room(0)
      roomObjects = thisRoom[0]
      puts thisRoom[2]
      validExits = thisRoom[1]
    elsif decision == "start" && gameStarted == true
      puts "Looks like you've already started the game!"
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
         roomObjects = thisRoom[0]
      else
        puts "Sorry, but that's not somewhere you can go."
      end
    elsif decision == 'look'
      puts thisRoom[2]
    elsif decision == 'inventory'
      puts playerInventory
    elsif decision.include? 'get'
      targetObject = parse_input(decision)
      if roomObjects.include? targetObject
        playerInventory.push(targetObject)
        roomObjects.slice!(roomObjects.index(targetObject))
        puts playerInventory
      else
        puts "That does not appear to be something you can grab..."
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

  start:     Begin the game
  quit:      Exit the game
  move:      Move in a valid direction
  get:       Retrieve item from room
  look:      Look at the room
  inventory: Display your current items
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
