class Insult
  PREFIXES = %w{Ass Jack Dill Turd Cock Twat Fart Booger Splooge Nut Douche Poon Queef Cunt Wank Butt}
  POSTFIXES = %w{Hat Wagon Roger Troll Sniffer Gnome Inspector Waffle Fairy Wad Master Peddler Weasel Taco Sack Receptacle Pilot Dumpster Pile Goblin}
  
  attr_accessor :prefix, :postfix

  def initialize(prefix, postfix)
    @prefix = prefix.to_i
    @postfix = postfix.to_i
  end

  def self.generate
    self.new(rand(PREFIXES.size), rand(POSTFIXES.size))
  end

  def link
    "/#{prefix}/#{postfix}"
  end

  def to_s
    "#{PREFIXES[prefix]} #{POSTFIXES[postfix]}"
  end
end

