module Edition::Identifiable
  extend ActiveSupport::Concern
  extend Forwardable

  included do
    belongs_to :document
    validates :document, presence: true
    before_validation :ensure_presence_of_document, on: :create
    before_validation :update_document_slug, on: :update
    before_validation :propagate_type_to_document
  end

  def_delegators :document, :slug, :change_history
  def_delegator :document, :published?, :linkable?

  def ensure_presence_of_document
    self.document ||= Document.new(sluggable_string: self.sluggable_title)
  end

  def update_document_slug
    document.update_slug_if_possible(self.sluggable_title)
  end

  def propagate_type_to_document
    document.document_type = type if document
  end

  module ClassMethods
    def published_as(id)
      document = Document.where(document_type: sti_name).find(id)
      document && document.published_edition
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
end
