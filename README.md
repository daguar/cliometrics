Cliometrics
---

Understanding a project's history through commits

### Setup

You need to set a GitHub token in the environment as GITHUB_TOKEN.

When running tests, a valid token is required if you want to actually hit the GitHub API (i.e., if you delete the VCR cassettes in spec/fixtures/vcr_cassettes) but setting the env var to anything will let the tests pass if you don't want to actually hit the API.

### Current Issues

- Times are in UTC; minimal impact since we're aggregating to weeks, but worth changing to Pacific at some point

### Copyright & License

Copyright Dave Guarino, 2014
BSD License
