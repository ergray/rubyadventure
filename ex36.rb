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
  worldObjects = ["sword", "shield"]
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
      thisRoom = show_room(0)
      roomObjects = populate_room_items(worldObjects, thisRoom[0])
      puts thisRoom[2]
      validExits = thisRoom[1]
      show_room_items(roomObjects)
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
         roomObjects = populate_room_items(worldObjects, thisRoom[0])
         puts thisRoom[2]
         validExits = thisRoom[1]
         show_room_items(roomObjects)
      else
        puts "Sorry, but that's not somewhere you can go."
      end
    elsif decision == 'look'
      puts thisRoom[2]
      show_room_items(roomObjects)
    elsif decision == 'inventory'
      puts playerInventory
    elsif decision.include? 'get'
      targetObject = parse_input(decision)
      if roomObjects.include? targetObject
        playerInventory.push(targetObject)
        roomObjects.slice!(roomObjects.index(targetObject))
        worldObjects.slice!(worldObjects.index(targetObject))
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

def populate_room_items(world_inventory, room_list)
  room_items = []
  room_list.each {|item|
    if world_inventory.index(item) != nil
      room_items.push(item)
    end
  }
  return room_items
end

def show_room_items(array)
  array.each{|item| puts "You see a #{item} here."}
end

def help
  puts """
  Here are a list of commands for the game:

  start:      Begin the game
  quit:       Exit the game
  move:       Move in a valid direction
  get:        Retrieve item from room
  look:       Look at the room
  inventory:  Display your current items
  use [item]: Use item in your inventory
  """
end

def show_room(roomNumber)
   rooms = [
  [['sword', 'shield'], [1, nil, nil, nil, nil, nil], "You are standing in the entrance of a dark cave.\nThe mouth of this cave is only barely taller than\nyou are and leads into a vast darkness."],
  [[], [nil, 2, 0, 3, nil, nil], "Here is the next room. It strangely\n looks like an office lobby. A woman\n with a nameplate which reads 'Jessica' \nis looking at you."],
  [[], [nil, nil, nil, 1, nil, nil], "You are in a security room! It is not parcitularly exciting.\nOn the one of the screens you can see the room\nyou just came from. Jessica sits idly at the desk."],
  [[], [nil, 1, nil, nil, 4, nil], "This is an elevator. There is a panel with\n buttons which will take you up or down."],
  [[], [nil, 7, nil, nil, 5, 3], "This is the second floor elevator. You can take\n it up or down, or exit to the east."],
  [[], [nil, 8, nil, nil, 6, 4], "You are on the third floor. You can take the\nelevator up or down, or exit to the east."],
  [[], [nil, 9, nil, nil, nil, 5], "You are on the top floor. You can take the\nelevator down, or exit to the east."],
  [[], [11, 10, nil, 4, nil, nil], "This appears to be a lobby similar to the ground\nfloor. Except that all the walls are a cave and the front\nreception desk is a few barrels with wood over the top\nand the receptionist is a goblin."],
  [[], [nil, 12, nil, 5, nil, nil], "Whoa, it's a lobby but this time it's in the\nfuture! There's a bunch of holograms and other things I should\nspend more time trying to write better!"],
  [[], [15, 16, nil, 6, nil, nil], "Penthouse! It's so faaaaancy~~"],
  [[], [nil, nil, nil, 7, nil, nil], "Treasure room!"],
  [[], [nil, nil, 7, nil, nil, nil], "Rickety bridge!"],
  [[], [nil, 13, nil, 8, nil, nil], "Sci-fi Market!"],
  [[], [nil, 14, nil, 12, nil, nil], "Stasis Room."],
  [[], [nil, nil, nil, 13, nil, nil], "Stasis Pod."],
  [[], [nil, nil, 9, nil, nil, nil], "Fancy bedroom!"],
  [[], [nil, nil, nil, 9, nil, nil], "Office!"]
  ]
  return rooms[roomNumber]
end


game
