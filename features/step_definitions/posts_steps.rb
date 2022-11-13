# Add a declarative step here for populating the DB with movies.

Given /the following posts exist/ do |posts_table|
  posts_table.hashes.each do |post|
    Post.create(post)
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Given /I have not logged in/ do
  expect(page).to have_no_content("Welcome")
end

Given /I have login as (.*) with password (.*)/ do |username, password|
  visit '/login'
  fill_in "user_name", :with => username
  fill_in "password", :with => password
  click_on 'login-but'
end 

When /I try to login as (.*) with password (.*)/ do |username, password|
  fill_in "user_name", :with => username
  fill_in "password", :with => password
  click_on 'login-but'
end 

When /I input "(.*)" in "(.*)" input bar/ do |keyword, bar|
  if bar == "Search by title"
    fill_in :search_by_title, :with => keyword
  elsif bar == "Search by zipcode"
    fill_in :search_by_zipcode, :with => keyword
  end
end

Then /(.*) seed posts should exist/ do | n_seeds |
  expect(Post.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

# Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#   #  ensure that that e1 occurs before e2.
#   #  page.body is the entire content of the page as a string.
#   pending "Fill in this step in movie_steps.rb"
# end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  pending "Fill in this step in movie_steps.rb"
end

# Part 2, Step 3
Then /^the following posts should (not )?show: (.*)/ do |no, post_list|
    post_list.split(',').each do |post| 
      post.gsub!('"', '') 
      if no 
        expect(page).to have_no_content(post) 
      else 
        expect(page).to have_content(post) 
      end 
    end 
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  pending "Fill in this step in movie_steps.rb"
end

### Utility Steps Just for this assignment.

Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
   require "byebug"; byebug
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end


Then /complete the rest of of this scenario/ do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  fail "Remove this step from your .feature files"
end
