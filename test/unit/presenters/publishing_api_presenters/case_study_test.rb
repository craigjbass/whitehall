require 'test_helper'

class PublishingApiPresenters::CaseStudyTest < ActiveSupport::TestCase

  def present(edition)
    PublishingApiPresenters::CaseStudy.new(edition).as_json
  end

  test "case studies are presented with barebones content for the publishing API" do
    case_study = create(:published_case_study,
                    title: 'Case study title',
                    summary: 'The summary',
                    body: 'Some content')

    public_path = Whitehall.url_maker.public_document_path(case_study)
    expected_hash = {
      title: 'Case study title',
      description: 'The summary',
      base_path: public_path,
      format: 'case_study',
      need_ids: [],
      public_updated_at: case_study.public_timestamp,
      update_type: 'major',
      publishing_app: 'whitehall',
      rendering_app: 'whitehall-frontend',
      routes: [
        { path: public_path, type: 'exact' }
      ],
      redirects: [],
      details: {
        body: "<div class=\"govspeak\"><p>Some content</p></div>",
        first_published_at: case_study.first_public_at,
        change_note: nil,
        tags: {
          browse_pages: [],
          topics: []
        }
      },
    }
    presented_hash = present(case_study)

    assert_equal_hash expected_hash.except(:details),
      presented_hash.except(:details)

    # We test for HTML equivlance rather than string equality to get around
    # inconsistencies with line breaks between different XML libraries
    assert_equivalent_html expected_hash[:details].delete(:body),
      presented_hash[:details].delete(:body)

    assert_equal expected_hash[:details], presented_hash[:details]
  end

  def assert_equal_hash(expected, actual)
    assert_equal expected, actual,
      "Hashes do not match. Differences are:\n\n#{mu_pp(expected.diff(actual))}\n"
  end
end
