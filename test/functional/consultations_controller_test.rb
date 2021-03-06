require "test_helper"

class ConsultationsControllerTest < ActionController::TestCase
  should_be_a_public_facing_controller

  test 'index redirects to the publications index filtering consultations, retaining any other filter params' do
    get :index, params: { topics: ["a-topic-slug"], departments: ['an-org-slug'] }
    assert_redirected_to(
      "http://test.host/government/publications.departments%255B%255D=an-org-slug&publication_filter_option=consultations&topics%255B%255D=a-topic-slug"
    )
  end
end
