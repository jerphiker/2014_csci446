# => 
# => Herb player -- by Jeremy Kerr
# => 
# => instance vars - shoot, pivot, save, rest, attack, etc..., used in decision making, passed to function choosemove
# => class var - health and pivotcooldown, defined early and used to prevent too much pivoting and to detect damage
# => constants - player health - used to manage how much he heals. Herb less likely to heal as he gains health
# => array - two arrays, store lookforward and lookbackward, used to detect enemies and respond appropriately
# => hash - no hash
# => functions - chooseMove - passed numbers for various moves as weights, chooses randomly between them. Higher weights mean better odds.
# => comments - see below

class Player
  PLAYER_HEALTH = 20  # => used to determine when to heal
  @@health = PLAYER_HEALTH  # => used to determine when player takes damage
  @@pivotCooldown = 0 # => used to prevent constant turning
  
  @@turn = 0  # => makes warrior pivot once at the beginning of each level
  
  def play_turn(warrior)
    @currentHealth = warrior.health # => used to determine when player takes damage
    @lookforward = warrior.look # => used to find enemies/captives
    @lookbackward = warrior.look(:backward) # => used to find enemies/captives
    @feelFront = warrior.feel # => allows warrior to attack instead of shoot if enemy is close, or to to anything within one square
    @feelBack = warrior.feel(:backward) # => intended to be used to free captives behind, but it doesn't quite work right
    
    @takingDamage = @currentHealth < @@health # => boolean to see when damage is dealt
    @@health = @currentHealth # => resets so damage doesn't always appear to be happening after first damage
    
    @@pivotCooldown = @@pivotCooldown - 1 # => cools down pivot so it can be used again
    
    @shoot = 0
    @pivot = 0
    @save = 0
    @rest = 0
    @attack = 0
    @goback = 0
    @walk = 0
    @saveBack = 0
    
    if (@lookforward[2].enemy? && @lookbackward[1].enemy?) || (@lookforward[1].enemy? && @lookbackward[2].enemy?) # => for when enemies are on both sides, to prevent unnecessary turning/backing up
      @shoot = @shoot + 100
    end
    
    if @feelFront.empty? && !@lookforward[1].enemy? # => for general walking and resting
      @walk = @walk + 1
      @rest = (PLAYER_HEALTH - @currentHealth) / 2  # => resting less likely as health increases
    elsif @feelFront.stairs?  # => go to the stairs to win
      @walk = @walk + 10
    elsif @feelFront.enemy? # => attack enemies
      @attack = @attack + 1
    elsif @feelFront.captive? # => free captives
      @save = @save + 15
    elsif @feelFront.wall?  # => pivot at walls
      @pivot = @pivot + 1
    elsif @feelFront.ticking? # => don't chill at bombs
      @goback = 1
    end
    
    if @lookforward[0].captive? # => save captives
      @save = @save + 10
    end
    
    if @lookforward[1].enemy? || @lookforward[2].enemy? # => don't get to close unless health is good
      if @currentHealth == PLAYER_HEALTH
        @goback = @goback
      else
        @goback = @goback + ( (PLAYER_HEALTH - @currentHealth) / 2 )
      end
    end
    
    if @lookforward[2].enemy? && !@lookforward[1].captive? && !@lookforward[0].captive? # => don't shoot captives
      @shoot = @shoot + 10
    end
    
    if @lookbackward[1].enemy?  # => don't get hit from behind
      if @@pivotCooldown <= 0
        @pivot = @pivot + 10
      end
    end
    
    if @feelBack.wall?  # => don't back into walls
      @goback = 0
    end
    
    if @feelBack.captive? # => save captives behind you
      @saveback = @saveBack + 10
    end
    
    if @feelFront.enemy?  # => don't shoot enemies in front of you
      @shoot = 0
    end
    
    if @@turn > 0 # => turn around first turn
      chooseMove(@shoot, @pivot, @save, @rest, @attack, @goback, @saveBack, @walk, warrior)
    else
      @@turn = 1
      warrior.pivot!
    end
  end
  
  def chooseMove(shoot, pivot, save, rest, attack, goback, saveBack, walk, warrior)
    @range = rand(shoot + pivot + save + rest + attack + saveBack + walk + goback)  # => randomly choose between available weighted options
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
