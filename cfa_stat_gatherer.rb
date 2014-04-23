require 'pry'
require 'csv'
require './lib/cliometrics'

# Most 2013 repos
cfa_repos = %w(ohana-api ohana-web-search cityvoice promptly public-records ohanakapa-ruby bizfriendly-web streetmix bizfriendly-api lv-trucks-map click_that_hood lv-trucks-notifier food_trucks fast_pass in-n-out criminal_case_search trailsyserver trailsy tourserver hermes-dashboard hermes-doc hermes-be)

# Most 2013 repos demoed at the summit
summit_repos = %w(ohana-api ohana-web-search cityvoice promptly public-records bizfriendly-web streetmix bizfriendly-api click_that_hood fast_pass in-n-out criminal_case_search trailsyserver trailsy tourserver)

# Pretty much the "big project" per city
city_repos = %w(ohana-api ohana-web-search cityvoice promptly public-records bizfriendly-web bizfriendly-api lv-trucks-map lv-trucks-notifier food_trucks fast_pass in-n-out criminal_case_search trailsyserver trailsy)

client = Cliometrics::Client.new(2013)

# Set up an array of arrays (with header row) for CSV production
full_result_set_array = Array.new
header_row = ['Repository Name']
(0..52).each do |week_index|
  header_row << week_index
end
full_result_set_array << header_row

# Do city repos for now
city_repos.each do |repo_name|
  puts "Processing #{repo_name}"
  array_for_single_repo = [repo_name]
  commit_set = Cliometrics::CommitSet.new(client.get_commits_for(repo_name))
  commit_set.commits_by_week.each do |commit_count_for_week|
    array_for_single_repo << commit_count_for_week
  end
  full_result_set_array << array_for_single_repo
end

# Write CSV output
CSV.open("stats_for_2013.csv", "w") do |csv|
  full_result_set_array.each do |row|
    csv << row
  end
end

binding.pry
