require 'roda'
require 'tilt/erb'
# require './models'

class Godbound < Roda
  plugin :render
  plugin :assets, css: 'style.scss'
  compile_assets

  route do |r|
    r.assets
    r.root do
      words = %w(
        Alacrity Apotheosis Artifice Beasts Bow Command Death Deception Earth
        Endurance Fate Fertility Fire Health Journeying Knowledge Luck Might Night
        Passion Sea Shapeshifting Sky Sorcery Sun Sword Time Wealth
      )
      @words = words.sample(3)
      render(:index)
    end
  end
end
