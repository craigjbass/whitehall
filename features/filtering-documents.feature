@not-quite-as-fake-search
Feature: Filtering Documents

  As a citizen, I want to be able to browse various types of content by filtering down by the following attributes.

  - Publications (inc. Consultations & Statistics):
    - Keyword
    - Publication type
    - Topic
    - Department
    - Official document status
    - World locations
    - Published date

  - Policies
    - Keyword
    - Topic
    - Department

  - Announcements
    - Keyword
    - Announcement type
    - Topic
    - Department
    - World Location
    - Published date

  - Viewing translated index page
    - e.g. https://www.gov.uk/government/announcements.fr?include_world_location_news=1&world_locations[]=france

    - c.f. world-location-news.feature

  Scenario: Filtering publications
    Given there are some published publications
    When I visit the publications index page
    Then I should be able to filter publications by keyword, publication type, topic, department, official document status, world location, and publication date

  @javascript
  Scenario: Filtering publications in a javascript-enabled browser
    Given there are some published publications
    When I visit the publications index page
