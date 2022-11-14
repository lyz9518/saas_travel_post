Feature: Add review to a post

  As user who just opened a post, I should be able to
  leave a comment about what I think about the post

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

Scenario: add new review to a post
  When I am on the home page
  And I click "I had so much fun here"
  Then I should not see "This post is super helpful!"
  When I click "Add Review"
  Then I should see "Create New Review"
  When I fill in "Review Content" with "This post is super helpful!"
  And I press "review-but"
  Then I should see "Details about I had so much fun here" 
  And I should see "This post is super helpful!" 

Scenario: I can't add new review with empty content
  When I am on the home page
  And I click "I had so much fun here"
  Then I should not see "This post is super helpful!"
  When I click "Add Review"
  And I press "review-but"
  Then I should see "Content can't be empty"
  And I should not see "Details about I had so much fun here" 
