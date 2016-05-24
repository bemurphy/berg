require "main/import"

module Main
  module Operations
    module Projects
      class CheckPublicationState
        include Main::Import("main.persistence.repositories.projects")
        include Dry::ResultMatcher.for(:call)

        def call(slug)
          post = projects.by_slug(slug)

          if project && project.status == "published"
            Right(post)
          else
            Left("This project has not yet been published.")
          end
        end
      end
    end
  end
end
