Feature: Creator should be able to update information about a post

  As a creator of the post, 
  So that I can update the information about a post

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

Scenario: Creator update the post
  Given I have login as lion with password 123
  When I am on the home page
  And I click "Check out Here!"
  And I click "Edit"
  Then I should see "Edit Existing Post"
  And I fill in "Title" with "Check out There!"
  And I fill in "Description" with "Updated Description for Check out There!"
  And I press "edit-submit-but"
  Then I should see "Check out There! was successfully updated."
  When I am on the home page
  Then I should see "Check out There!"

Scenario: Non-Creator try to update the post
  Given I have login as lion with password 123
  When I am on the home page
  And I click "I had so much fun here"
  And I click "Edit"
  Then I should see "Only creator can edit the post"

Scenario: Creator delete the post
  Given I have login as lion with password 123
  When I am on the home page
  And I click "Check out Here!"
  And I click "Delete"
  And I agree in pop up window
  Then I should see "deleted"

Scenario: Non-creator can't delete the post
  Given I am on the home page
  And I click "Check out Here!"
  And I click "Delete"
  And I agree in pop up window
  Then I should see "Only creator can delete the post"

