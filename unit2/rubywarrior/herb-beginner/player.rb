class Player
  @@health = 20
  def play_turn(warrior)
    @currentHealth = warrior.health
    if @currentHealth < @@health  # => Herb is taking damage
      @@health = @currentHealth
      if warrior.feel.enemy?
        warrior.attack!
      elsif @currentHealth < 9
        warrior.walk!(:backward)
      else
        warrior.walk!
      end
    else
      if warrior.feel.enemy?
        warrior.attack!
      elsif @currentHealth < 20
        @@health = @currentHealth + 2
        if @@health == 21
          @@health = 20
        end
        warrior.rest!
      else
        warrior.walk!
      end
    end
  end
end
