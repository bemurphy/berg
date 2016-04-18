require "rom-repository"
require "icelab_com_au/container"
require "icelab_com_au/import"

IcelabComAu::Container.boot! :rom

module IcelabComAu
  class Repository < ROM::Repository
    # This .new shouldn't be needed, since repos should work with dry-
    # auto_inject. This is not working yet, so this remains as a workaround.
    def self.new(rom = nil)
      super(rom || IcelabComAu::Container["persistence.rom"])
    end
  end
end
