require "kleisli"
require "admin/entities/admin_user"
require "admin/import"
require "transproc"

module Admin
  module Operations
    class CreateAdminUser
      include Admin::Import(
        "admin.authentication.encrypt_password",
        "admin.validation.admin_user_form_schema",
        "core.persistence.create_admin_user"
      )

      extend Transproc::Registry
      import Transproc::HashTransformations

      def call(params = {})
        validation = admin_user_form_schema.(params)

        if validation.messages.any?
          Left(validation.messages)
        else
          result = create_admin_user.(prepare_attributes(validation.params))
          Right(Entities::AdminUser.new(result))
        end
      end

      private

      def prepare_attributes(params)
        attrs = transformer.(params)
        attrs.merge(encrypted_password: encrypt_password.(params[:password]))
      end

      def transformer
        self.class[:accept_keys, [
          :email,
          :name
        ]]
      end
    end
  end
end
