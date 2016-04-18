require_relative "admin/container"

Admin::Container.finalize! do |container|
  require "admin/enqueue"
  container.register :enqueue, Admin::Enqueue.new
end

require "admin/application"
require "admin/view"
require "admin/transactions"

Admin::Container.require "transactions/**/*.rb"
