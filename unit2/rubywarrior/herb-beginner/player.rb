class Player
  PLAYER_HEALTH = 20
  @@health = PLAYER_HEALTH
  @@pivotCooldown = 0
  
  def play_turn(warrior)
    @currentHealth = warrior.health
    @lookforward = warrior.look
    @lookbackward = warrior.look(:backward)
    @feelFront = warrior.feel
    @feelBack = warrior.feel(:backward)
    
    @takingDamage = @currentHealth < @@health
    @@health = @currentHealth
    
    @@pivotCooldown = @@pivotCooldown - 1
    
    @shoot = 0
    @pivot = 0
    @save = 0
    @rest = 0
    @attack = 0
    @goback = 0
    @walk = 0
    @saveBack = 0
    
    if @feelFront.empty?
      @walk = @walk + 1
      if !@takingDamage
        @rest = (PLAYER_HEALTH - @currentHealth) / 2
      end
    elsif @feelFront.stairs?
      @walk = @walk + 100
    elsif @feelFront.enemy?
      @attack = @attack + 1
    elsif @feelFront.captive?
      @save = @save + 1
    elsif @feelFront.wall?
      @pivot = @pivot + 1
    elsif @feelFront.ticking?
      @goback = 1
    end
    
    if @lookforward[0].captive?
      @save = @save + 10
    end
    
    if @lookforward[1].enemy? || @lookforward[2].enemy?
      if @currentHealth == PLAYER_HEALTH
        @goback = @goback
      else
        @goback = @goback + ( (PLAYER_HEALTH - @currentHealth) / 2 )
      end
    end
    
    if @lookforward[2].enemy? && !@lookforward[1].captive? && !@lookforward[0].captive? 
      @shoot = @shoot + 10
    end
    
    if @lookbackward[1].enemy?
      if @@pivotCooldown <= 0
        @pivot = @pivot + 10
      end
    end
    
    if @feelBack.wall?
      @goback = 0
    end
    
    if @feelBack.captive?
      @saveback = @saveBack + 10
    end
    
    chooseMove(@shoot, @pivot, @save, @rest, @attack, @goback, @saveBack, @walk, warrior)
  end
  
  def chooseMove(shoot, pivot, save, rest, attack, goback, saveBack, walk, warrior)
    @range = rand(shoot + pivot + save + rest + attack + saveBack + walk + goback)
    if @range < shoot
      warrior.shoot!
    elsif @range < shoot + pivot
      @@pivotCooldown = 3
      warrior.pivot!
    elsif @range < shoot + pivot + save
      warrior.rescue!
    elsif @range < shoot + pivot + save + rest
      @@health = @@health + 2
      if @@health > PLAYER_HEALTH
        @@health = PLAYER_HEALTH
      end
      warrior.rest!
    elsif @range < shoot + pivot + save + rest + attack
      warrior.attack!
    elsif @range < shoot + pivot + save + rest + attack + goback
      warrior.walk!(:backward)
    elsif @range < shoot + pivot + save + rest + attack + goback + saveBack
      warrior.rescue!(:backward)
    else
      warrior.walk!
    end
  end
end
