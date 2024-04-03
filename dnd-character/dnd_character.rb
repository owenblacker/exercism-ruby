=begin
Write your code for the 'D&D Character' exercise in this file. Make the tests in
`dnd_character_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/dnd-character` directory.
=end

class DndCharacter
  attr_reader :strength
  attr_reader :dexterity
  attr_reader :constitution
  attr_reader :intelligence
  attr_reader :wisdom
  attr_reader :charisma

  def hitpoints
    constitution_modifier = self.class.modifier(@constitution)
    10 + constitution_modifier
  end
  
  def self.modifier(constitution)
    @constitution = constitution

    debug "Parameter: #{constitution}; instance var #{@constitution}"
    
    ((@constitution - 10) / 2).floor
  end

  def initialize
    @prng = Random.new

    @strength = self.roll_ability
    @dexterity = self.roll_ability
    @constitution = self.roll_ability
    @intelligence = self.roll_ability
    @wisdom = self.roll_ability
    @charisma = self.roll_ability

    debug_message = "STR %s, DEX %s, CON %s, INT %s, WIS %s, CHA %s"
    all_attributes = [ self.strength, self.dexterity, self.constitution, self.intelligence, self.wisdom, self.charisma ]
    debug debug_message % all_attributes
  end

  private
  
  def roll_ability
    return self.roll_dice.max(3).sum
  end

  def roll_dice
    return [ self.roll_one_die, self.roll_one_die, self.roll_one_die, self.roll_one_die ]
  end

  def roll_one_die
    return @prng.rand(1..6)
  end
end
