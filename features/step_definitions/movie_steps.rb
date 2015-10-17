# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end
 
 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! (movie)
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
   #remove this statement after implementing the test step
    uncheck("ratings_G")
    uncheck("ratings_PG")
    uncheck("ratings_PG-13")
    uncheck("ratings_R")
    click_button 'Refresh'
    arg1 =arg1.gsub(/[,]/,"")
    rating = arg1.split
    rating.each do |r|
     check("ratings_#{r}")
     click_button 'Refresh'
    end
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
   #remove this statement after implementing the test step
    arg1 = arg1.gsub(/[,]/,"")
    rate = arg1.split
    rate.each do |ra|
        expect(page).to have_content(ra)
    end    
end


Then /^I should see all of the movies$/ do
  #remove this statement after implementing the test step
  result2=false
  row=page.all('table tbody tr').count
  if (row==10)
      result2= true
  end
  expect(result2).to be_truthy
end

When /I follow "Movie Title"/ do
  click_link "title_header"
end
When /I follow "Release Date"/ do
  click_link "release_date_header"
end
Then /I should see "(.*)" before "(.*)"/ do |i1, i2|
    result1=false
    if ((page.body.index(i1))<(page.body.index(i2)))
        result1=true
    end
    expect(result1).to be_truthy
end