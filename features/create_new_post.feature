Feature: display list of movies filtered by MPAA rating

  As a traveler and local resident, 
  So that I can quickly explore interesting locations where I want to go
  I want to see others' posts matching the zipcode I entered.

Background: dummy posts have been added to database

  Given the following posts exist:
  | id | zipcode | title | creator_id | description | date |
  | 1 | 10463 | Check out Here! | 1 | hello world | 2022-01-01 |
  | 2 | 10464 | You don't wanna miss this | 1 | Hi welcome | 2022-01-01 |
  | 3 | 10463 | I had so much fun here | 2 | hello USA | 2022-01-02 |


  And I am on the Good Points home page
  Then 3 seed posts should exist

Scenario: add new post to the website without logging in
  Given I have not logged in
  When I click "Add new post"
  Then I am on the login page

Scenario: add new post to the website with logging in
  Given I have login as lion with password 123
  And I am on the home page
  When I click "Add new post"
  Then I am on the new post page

Scenario: Login with correct username and password
  Given I have login as lion with password 123
  Then I am on the home page

Scenario: Login with non-existent username
  Given I have login as nonexistent with password 123
  Then I am on the login page

Scenario: Login with incorrect username
  Given I have login as lion with password randomike12345
  Then I am on the login page

