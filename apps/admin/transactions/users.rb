require "admin/transactions"

Admin::Transactions.define do |t|
  t.define "admin.transactions.create_user" do
    step :create, with: "admin.users.operations.create"
    enqueue :send_activation_email, with: "admin.users.operations.send_activation_email"
  end

  t.define "admin.transactions.request_password_reset" do
    step :update_access_token, with: "admin.users.operations.update_access_token"
    enqueue :send_reset_password_email, with: "admin.users.operations.send_reset_password_email"
  end
end
