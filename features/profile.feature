Feature: Users can view the profile pages

  As a user, 
  So that I checkout the profile pages of users

Background: dummy posts have been added to database

  Given the following posts exist:
  | zipcode | title | creator_id | description | date |
  | 10463 | Check out Here! | 1 | hello world | 2022-01-01 |
  | 10464 | You don't wanna miss this | 1 | Hi welcome | 2022-01-01 |
  | 10463 | I had so much fun here | 2 | hello USA | 2022-01-02 |

  Given the following users exist:
  | user_name | first_name | last_name | password |
  | lion | John | Smith | 123 |
  | king | Adam | Mctigue | 123 |


  And I am on the Good Points home page
  Then 3 seed posts should exist

Scenario: User Checkout his/her own profile page
  Given I have login as lion with password 123
  When I am on the home page
  And I click "lion"
  Then I should see "@lion"
  And I should see "Check out Here!"
  And I should see "You don't wanna miss this"
  And I should not see "I had so much fun here"

Scenario: User Checkout the user page for a post's creator
  Given I am on the home page
  When I click "//a[contains(text(),'Check out')]/../../../div[3]/div[2]/a" by xpath
  Then I should see "@lion"
  And I should see "Check out Here!"
  And I should see "You don't wanna miss this"
  And I should not see "I had so much fun here"