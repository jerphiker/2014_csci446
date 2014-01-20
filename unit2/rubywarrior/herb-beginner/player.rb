class Player
  @@health = 20
  def play_turn(warrior)
    @currentHealth = warrior.health
    if @currentHealth < @@health
      @@health = @currentHealth
      if warrior.feel.enemy?
        warrior.attack!
      elsif warrior.feel.captive?
        warrior.rescue!
      else
        warrior.walk!(:backward)
      end
    elsif warrior.feel.enemy?
      warrior.attack!
    elsif warrior.feel.captive?
      warrior.rescue!
    elsif warrior.health < 15
      warrior.rest!
    else
      warrior.walk!
    end
  end
end
