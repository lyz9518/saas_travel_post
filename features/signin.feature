Feature: User should be able to create new account

  As a user, 
  So that I can create account

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

Scenario: Create new account, and should be able to make new post
  Given I am on the home page
  When I press "nav-signup-but"
  Then I should see "Create A User Now"
  And I fill in "User name" with "testbot"
  And I fill in "First name" with "Test"
  And I fill in "Last name" with "Bot"
  And I fill in "Password" with "tmp"
  And I press "create-user"
  Then I should see "Welcome testbot"
  When I click "Add new post"
  Then I am on the new post page

Scenario: Can't Create new account with empty username
  Given I am on the home page
  When I press "nav-signup-but"
  Then I should see "Create A User Now"
  And I fill in "First name" with "Test"
  And I fill in "Last name" with "Bot"
  And I fill in "Password" with "tmp"
  And I press "create-user"
  Then I should see "User Name can't be empty"

Scenario: Can't Create new account with empty password
  Given I am on the home page
  When I press "nav-signup-but"
  Then I should see "Create A User Now"
  And I fill in "User name" with "testbot"
  And I fill in "First name" with "Test"
  And I fill in "Last name" with "Bot"
  And I press "create-user"
  Then I should see "Password can't be empty"

Scenario: Can't Create new account with empty first name
  Given I am on the home page
  When I press "nav-signup-but"
  Then I should see "Create A User Now"
  And I fill in "User name" with "testbot"
  And I fill in "Last name" with "Bot"
  And I fill in "Password" with "tmp"
  And I press "create-user"
  Then I should see "First name can't be empty"

Scenario: Can't Create new account with empty last name
  Given I am on the home page
  When I press "nav-signup-but"
  Then I should see "Create A User Now"
  And I fill in "User name" with "testbot"
  And I fill in "First name" with "Bot"
  And I fill in "Password" with "tmp"
  And I press "create-user"
  Then I should see "Last name can't be empty"


