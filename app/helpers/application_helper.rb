module ApplicationHelper
    def document_user(document_id)
        @users = User.where.not(collaborators: Collaborator.find_by(document_id: document_id))
    end
end
