require "kleisli"
require "admin/entities/user"
require "admin/import"
require "transproc"

module Admin
  module Operations
    class CreateUser
      include Admin::Import(
        "admin.persistence.repositories.users",
        "admin.authentication.encrypt_password",
        "admin.validation.user_form_schema",
      )

      extend Transproc::Registry
      import Transproc::HashTransformations

      def call(params = {})
        validation = user_form_schema.(params)

        if validation.messages.any?
          Left(validation.messages)
        else
          result = create_user.(prepare_attributes(validation.params))
          Right(Entities::User.new(result))
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
