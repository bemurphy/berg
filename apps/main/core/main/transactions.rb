require "dry-transaction"

require "berg/transactions"
require "main/container"
require "main/import"

module Main
  class Transactions < Berg::Transactions
    class StepAdapters < Dry::Transaction::StepAdapters
      class Enqueue
        include Main::Import("enqueue")

        def call(step, *args, input)
          enqueue.(step.operation_name, *args, input)
          Right(input)
        end
      end

      register :enqueue, Enqueue.new
    end

    configure do |config|
      config.container = Main::Container
      config.options = {step_adapters: StepAdapters}
    end
  end
end
