require 'rlua'

# dice functions
def self.d20
    return rand(1..20)
end

def self.d12
    return rand(1..12)
end

def self.d10
    return rand(1..10)
end

def self.d8
    return rand(1..8)
end

def self.d6
    return rand(1..6)
end

def self.d4
    return rand(1..4)
end

# trap function
def self.gameplayTrap
    # trap intellegence stat
    intTrapIntellegence = rand(1..10)
    # escape variable
    intEscapeVariable = d20
    
    if intEscapeVariable > intTrapIntellegence
        print "Your party escaped the trap.\n"
    else
        print "Your party did not escape the trap, Game Over\n"
        exit
    end
end

# enemy function
def self.enemy
    # enemy variables
    intEnemyType = rand(1..10)
    intEnemyTrust = rand(1..3)
    intEnemyStrength = rand(1..10)
    intEnemyColor = rand(1..7)
    intEnemyOutlineColor = rand(1..7)

    # case statement for enemy outline color
    case intEnemyOutlineColor
        when 1
            print "The enemy outline color is: red\n"
        when 2
            print "The enemy outline color is: orange\n"
        when 3
            print "The enemy outline color is: yellow\n"
        when 4
            print "The enemy outline color is: green\n"
        when 5
            print "The enemy outline color is: blue\n"
        when 6
            print "The enemy outline color is: purple\n"
        when 7
            print "The enemy outline color is: black\n"
    end

    # case statement for enemy color
    case intEnemyColor
        when 1
            print "The enemy color is: red\n"
        when 2
            print "The enemy color is: orange\n"
        when 3
            print "The enemy color is: yellow\n"
        when 4
            print "The enemy color is: green\n"
        when 5
            print "The enemy color is: blue\n"
        when 6
            print "The enemy color is: purple\n"
        when 7
            print "The enemy color is: black\n"
    end

    # case statement for enemy type
    case intEnemyType
        when 1
            print "You have encountered a fingerblade killer, what will you do, 0:attack, 1:Talk:\n"
        when 2
            print "You have encountered a vampire, what will you do, 0:attack, 1:Talk:\n"
        when 3
            print "You have encountered a giant ant, what will you do, 0:attack, 1:Talk:\n"
        when 4
            print "You have encountered a leprechaun, what will you do, 0:attack, 1:Talk:\n"
        when 5
            print "You have encountered a chair monster, what will you do, 0:attack, 1:Talk:\n"
        when 6
            print "You have encountered a barrel monster, what will you do, 0:attack, 1:Talk:\n"
        when 7
            print "You have encountered a robot with chainsaws for teeth, what will you do, 0:attack, 1:Talk:\n"
        when 8
            print "You have encountered a dragon, what will you do, 0:attack, 1:Talk:\n"
        when 9
            print "You have encountered a wyvern, what will you do, 0:attack, 1:Talk:\n"
        when 10
            print "You have encountered a tree monster, what will you do, 0:attack, 1:Talk:\n"
    end

    # variable for option
    intOption = gets.chomp.to_i
    # options logic
    if intOption == 0
        # logic for attack
        intConvinceVariable = d20
        if intConvinceVariable == 20
            print "You defeated the enemy.\n"
        else
            print "Game Over\n"
            exit
        end

    elsif intOption == 1
        # case statement for enemy trust
        case intEnemyTrust
            when 1
                intConvinceVariable = d12
                if intConvinceVariable == 12
                    print "You convinced the enemy to leave you alone\n"
                else
                    print "Game Over\n"
                    exit
                end
            when 2
                intConvinceVariable = d6
                if intConvinceVariable == 6
                    print "You convinced the enemy to leave you alone\n"
                else
                    print "Game Over\n"
                    exit
                end
            when 3
                intConvinceVariable = d4
                if intConvinceVariable == 4
                    print "You convinced the enemy to leave you alone\n"
                else
                    print "Game Over\n"
                    exit
                end
        end
    else
        print "Not An Option, Game Over\n"
        exit
    end
end

# Copyright disclaimer
print "Copyright (C) 2024-2026 Daniel\n"
print "Hanrahan Tools and Games\n"
# GNU GPL disclaimer
print "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the license, or (at your option) any later version. This program is distributed in hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have recieved a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses\n"
# Creative Commons Attribution-Sharealike disclaimer
print "Information just about the stuff in this\n"
print "software not covered by the GNU General\n"
print "Public License version 3: This work is\n"
print "licensed under Attribution-ShareAlike\n"
print "4.0 International\n"
# info about fusions
print "The player is 2 people that fuses and defuses at random\n"

# The Game itself
print "What is your name:\n"
strName = gets.chomp # Added .chomp to clean up trailing newlines
# Mod Prompt
print "Would you like to use add-on mods(y or n)?\n"
strModPrompt = gets.chomp # FIXED: Added .chomp here so it cleanly evaluates to "y" or "n"

if strModPrompt == "y"
    lua = Lua::State.new
    
    lua_file = File.expand_path("The_Game_Of_Trusters_Mod.lua", __dir__)
    if File.exist?(lua_file)
        lua_code = File.read(lua_file)
        
        # A pure-math randomizer that requires ZERO built-in Lua functions.
        # It relies on an internal seed that shifts predictably every time it's called.
        lua_stub = <<~LUA
          local _seed = 42
          math = {
            random = function(min, max)
              _seed = (1103515245 * _seed + 12345) % 2147483648
              return (_seed % (max - min + 1)) + min
            end
          }
        LUA
        
        # Combine the math stub with your unchanged Lua code
        lua.__eval(lua_stub + lua_code)
        
        print lua["strNoticeAndName"]
    else
        print "Could not find Mod file at #{lua_file}, Please restart or exit now\n"
        exit
    end
    print "You have chosen to use add-on mods\n"
elsif strModPrompt == "n"
    print "You have not chosen to use add-on mods\n"
else
    print "Not an Option, Game Over\n"
    exit # FIXED: Exit here if they enter something else, so it doesn't continue down
end

index = 1
while index == 1
    # fusion mechanic
    intFuseState = rand(1..2)
    if intFuseState == 1
        print "The player is not fused\n"
    else
        print "The player is fused\n"
    end

    # results to check if add-on mod is selected
    if strModPrompt == "y"
        # The results including rooms
        intResult = rand(2..11)
        case intResult
        when 2
            print "Left (1 then enter), Right (2 then enter):\n"
            intDirection = gets.chomp.to_i
            # FIXED: Correct condition checking layout syntax
            if intDirection == 1 || intDirection == 2
                if intDirection == 1
                    print "You went Left\n" # Cleaned up /n to \n
                elsif intDirection == 2
                    print "You went Right\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 3
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 4
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter), Up (4 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3 || intDirection == 4
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                elsif intDirection == 4
                    print "You went Up\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 5
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter), Up (4 then enter), Down (5 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3 || intDirection == 4 || intDirection == 5
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                elsif intDirection == 4
                    print "You went Up\n"
                elsif intDirection == 5
                    print "You went Down\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 6
            enemy
        when 7
            gameplayTrap
        when 8
            print lua["strPlayerLocationState1"]
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 9
            print lua["strPlayerLocationState2"]
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 10
            print lua["strEnemy1"]
            intAction = gets.chomp.to_i
            if intAction == 0 || intAction == 1
                if intAction == 0
                    intModDice = lua["intDice"]
                    if intModDice == 1
                        print "You defeated the enemy\n"
                    elsif intModDice == 2
                        print "You were defeated by the enemy, Game Over\n"
                        exit
                    end
                elsif intAction == 1
                    intModDice = lua["intDice"]
                    if intModDice == 1
                        print "You convinced the enemy to leave you alone\n"
                    elsif intModDice == 2
                        print "You did not convinced the enemy to leave you alone, Game Over\n"
                        exit
                    end
                end
            else
                print "Not an Option\n"
                exit
            end
        when 11
            print lua["strEnemy2"]
            intAction = gets.chomp.to_i
            if intAction == 0 || intAction == 1
                if intAction == 0
                    intModDice = lua["intDice"]
                    if intModDice == 1
                        print "You defeated the enemy\n"
                    elsif intModDice == 2
                        print "You were defeated by the enemy, Game Over\n"
                        exit
                    end
                elsif intAction == 1
                    intModDice = lua["intDice"]
                    if intModDice == 1
                        print "You convinced the enemy to leave you alone\n"
                    elsif intModDice == 2
                        print "You did not convinced the enemy to leave you alone, Game Over\n"
                        exit
                    end
                end
            else
                print "Not an Option\n"
                exit
            end
        end
    elsif strModPrompt == "n"
        # The results including rooms
        intResult = rand(2..7)
        case intResult
        when 2
            print "Left (1 then enter), Right (2 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 3
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 4
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter), Up (4 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3 || intDirection == 4
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                elsif intDirection == 4
                    print "You went Up\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 5
            print "Left (1 then enter), Right (2 then enter), Straight (3 then enter), Up (4 then enter), Down (5 then enter):\n"
            intDirection = gets.chomp.to_i
            if intDirection == 1 || intDirection == 2 || intDirection == 3 || intDirection == 4 || intDirection == 5
                if intDirection == 1
                    print "You went Left\n"
                elsif intDirection == 2
                    print "You went Right\n"
                elsif intDirection == 3
                    print "You went Straight\n"
                elsif intDirection == 4
                    print "You went Up\n"
                elsif intDirection == 5
                    print "You went Down\n"
                end
            else
                print "Not an Option\n"
                exit
            end
        when 6
            enemy
        when 7
            gameplayTrap
        end
    end
end
