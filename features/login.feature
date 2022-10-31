Feature: User should be able to login with valid username and password

  As a user, 
  So that I can login to my account

Background: dummy posts and users have been added to database

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

Scenario: Login with correct username and password, and should be able to make new post
  Given I am on the login page
  When I try to login as lion with password 123
  Then I should see "Login successfully"
  When I click "Add new post"
  Then I am on the new post page

Scenario: Login with non-existent username
  Given I am on the login page
  When I try to login as notext with password 123
  Then I should see "No such user find"

Scenario: Login with incorrect username
  Given I am on the login page
  When I try to login as lion with password 321
  Then I should see "Wrong password"

