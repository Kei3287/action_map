Feature: Show representatives of a county when it is clicked
 
  As a voter
  So that I can view relevant representatives
  I want to see representatives from my county and up

Background: A county has a list of representatives
 
  Given the following representatives exist:
  | Name                   | County                              | 
  | Catherine Cortez Masto | US Senator NV                       |
  | Steve Sisolak          | Governor of NV                      |
  | Mark Gibbons           | NV Supreme Court of Justice         |
  | Nancy Parent           | Washoe County Clerk                 |
  | Dianne Feinstein       | US Senator CA                       |
  | Gavin Newsom           | Governor of CA                      |
  | Betty T. Yee           | CA State Controller                 |
  | Phong La               | Alameda County Assessor             | 
  | Donald J. Trump        | President of the United States      |
  | Mike Pence             | Vice President of the United States |


  And  I am on the RottenPotatoes home page
  Then 10 seed movies should exist

Scenario: restrict to movies with 'PG' or 'R' ratings
  Given I am on the RottenPotatoes home page
  # enter step(s) to check the 'PG' and 'R' checkboxes
  When I check the following ratings: PG, R
  # enter step(s) to uncheck all other checkboxes
  And I uncheck the following ratings: PG-13, G
  # enter step to "submit" the search form on the homepage
  And I press "Refresh"
  # enter step(s) to ensure that PG and R movies are visible
  Then I should see "The Incredibles"