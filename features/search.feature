Feature: search representatives by address

  As a user of action map
  So I can search for the representatives
  I want to know the representatives either by entering the address or clicking the map

Background: call google civic api for CA

Scenario: I search the representatives by address

  Given I am on the representatives page
  When I fill in "CA" for "address"
  When I submit "Search"
  Then I should see "Gavin Newsom"
