require "admin/transactions"

Admin::Transactions.define do |t|
  t.define "admin.transactions.password_reset_request" do
    step :update_access_token, with: "admin.users.operations.update_access_token"
    enqueue :send_password_reset_email, with: "admin.users.operations.send_password_reset_email"
  end
end
