# lita-jobs

Control jobs from yaml gem.

[![Gem Version](https://badge.fury.io/rb/lita-jobs.png)](http://badge.fury.io/rb/lita-jobs)
[![Build Status](https://secure.travis-ci.org/josacar/lita-jobs.png)](http://travis-ci.org/josacar/lita-jobs)
[![Coverage Status](https://coveralls.io/repos/josacar/lita-jobs/badge.png)](https://coveralls.io/r/josacar/lita-jobs)
[![Code Climate](https://codeclimate.com/github/josacar/lita-jobs.png)](https://codeclimate.com/github/josacar/lita-jobs)
[![Dependency Status](https://gemnasium.com/josacar/lita-jobs.png)](https://gemnasium.com/josacar/lita-jobs)

## Installation

Add lita-jobs to your Lita instance's Gemfile:

``` ruby
gem "lita-jobs"
```

## Usage

```
lita jobs list          - List active and finished jobs
lita jobs kill JOB_ID   - Kill an active job
lita jobs tail JOB_ID   - Print last output for a job
lita jobs output JOB_ID - Print output for a job
```

## License

[MIT](http://opensource.org/licenses/MIT)
