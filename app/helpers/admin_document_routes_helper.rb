module AdminDocumentRoutesHelper
  DOCUMENT_TYPES = [Policy, Publication]

  def self.documents_collection_route(name)
    DOCUMENT_TYPES.each do |type|
      method_name = name.to_s.gsub("admin_documents", "admin_#{type.model_name.plural}")
      class_eval %{
        def #{method_name}(*args)
          #{name}(*args)
        end
      }
    end
  end

  def self.document_instance_route(name)
    DOCUMENT_TYPES.each do |type|
      method_name = name.to_s.gsub("admin_document", "admin_#{type.model_name.singular}")
      class_eval %{
        def #{method_name}(*args)
          #{name}(*args)
        end
      }
    end
  end

  document_instance_route :admin_document_path
  document_instance_route :admin_document_fact_check_requests_path
  document_instance_route :admin_document_supporting_documents_path

  documents_collection_route :admin_documents_path
end