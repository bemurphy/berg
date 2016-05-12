require "spec_helper"

Dir[SPEC_ROOT.join("main/shared/app/**/*.rb").to_s].each(&method(:require))
