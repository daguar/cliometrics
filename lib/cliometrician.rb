require 'octokit'

class Cliometrician
  attr_reader :client, :year

  def initialize(year)
    raise "GitHub token missing: please set GITHUB_TOKEN in your environment" \
      unless ENV['GITHUB_TOKEN']
    raise "Bad year" unless year_valid?(year)
    @year = year
    @client = Octokit::Client.new \
      access_token: ENV['GITHUB_TOKEN'],
      auto_paginate: true
  end

  def get_commits_for(repo_name)
    @client.commits_between("codeforamerica/#{repo_name}", "#{year}-01-01", "#{year}-12-01")
  end

  private
  def year_valid?(year)
    fixnum_year = year.to_i
    current_year = DateTime.now.year
    return (2011..current_year).include?(fixnum_year)
  end
end
