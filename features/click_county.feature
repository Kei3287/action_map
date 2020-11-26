Feature: Show representatives of a county when it is clicked
 
  As a voter
  So that I can view relevant representatives
  I want to see representatives from my county and up

Scenario: Show Alameda county representatives when Alameda is clicked
  # Must be on a state's page
  Given I am on the California state page
  # Click on a county
  When I click on Alameda county
  # Should see representatives
  Then I should see Alameda representatives
  