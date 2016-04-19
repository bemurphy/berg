require "dry-transaction"

require "berg/transactions"
require "admin/container"
require "admin/import"

module Admin
  class Transactions < Berg::Transactions
    class StepAdapters < Dry::Transaction::StepAdapters
      class Enqueue
        include Admin::Import("enqueue")

        def call(step, *args, input)
          enqueue.(step.operation_name, *args, input)
          Right(input)
        end
      end

      register :enqueue, Enqueue.new
    end

    configure do |config|
      config.container = Admin::Container
      config.options = {step_adapters: StepAdapters}
    end
  end
end
