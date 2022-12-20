Feature: display list of posts filtered by users' search input, according to title and/or zipcode

  As a traveler and local resident, 
  So that I can quickly explore interesting posts and locations base on title and/or zipcode search
  I want to see others' posts matching the title and/or zipcode I entered.

Background: dummy posts have been added to database

  Given the following posts exist:
  | zipcode | title | creator_id | description | date | rating |
  | 10463 | Check out Here! | 1 | hello world | 2022-01-01 | 2 |
  | 10464 | You don't wanna miss this | 1 | Hi welcome | 2022-01-01 | 1 |
  | 10463 | I had so much fun here 1 | 2 | hello USA | 2022-01-02 | 4 |
  | 10001 | I had so much fun here 2 | 1 | hello USA | 2022-01-02 | 5 |

  Given the following users exist:
  | user_name | first_name | last_name | password |
  | lion | John | Smith | 123 |
  | king | Adam | Mctigue | 123 |


  And I am on the Good Points home page
  Then 4 seed posts should exist

Scenario: search for titles I am interested in
  When I input "out" in "Search by title" input bar
  And I click button "Search"
  Then the following posts should show: "Check out Here!"
  And the following posts should not show: "You don't wanna miss this","I had so much fun here 1","I had so much fun here 2"

Scenario: search for zipcode I am interested in
  When I input "10464" in "Search by zipcode" input bar
  And I click button "Search"
  Then the following posts should show: "You don't wanna miss this"
  And the following posts should not show: "Check out Here!","I had so much fun here 1","I had so much fun here 2"

  Scenario: search for zipcode sorted by rating
  When I input "10463" in "Search by zipcode" input bar
  And I check "Sort by rating"
  And I click button "Search"
  Then the following posts should show: "I had so much fun here 1","Check out Here!"
  And the following posts should not show: "You don't wanna miss this","I had so much fun here 2"


Scenario: search for titles I am interested in
  When I input "I had so much fun here" in "Search by title" input bar
  And I input "10001" in "Search by zipcode" input bar
  And I click button "Search"
  Then the following posts should show: "I had so much fun here 2"
  And the following posts should not show: "You don't wanna miss this","I had so much fun here 1","Check out Here!"