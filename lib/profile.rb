module Insult
  PREFIXES = %w{Ass Jack Dill Turd Cock Twat Fart Skank Booger Splooge Cooter Nut Douche Poon Queef Cunt Wank}
  POSTFIXES = %w{Butt Hat Wagon Roger Troll Sniffer Gnome Inspector Waffle Fairy Wad Master Peddler Smurf Weasel Taco Sack Receptacle Pilot}
  
  def self.generate
    "#{PREFIXES[rand(PREFIXES.size)]} #{POSTFIXES[rand(POSTFIXES.size)]}"
  end
end
