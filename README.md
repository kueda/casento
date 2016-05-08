# Description
The California Academy of Sciences has databased a great deal of their
entomological specimen data, but it's generally only available through
their own [website](http://researcharchive.calacademy.org/research/entomology/EntInv/index.asp)
with no API and no machine-readable export functionality. This gem attempts to
ameliorate the situation by scraping data and presenting it in a machine-
readable format.

Since it is just a scraper it is brittle, but still, better than nothing.

# Installation

This is a Ruby gem, so you'll need [Ruby](https://www.ruby-lang.org) and [RubyGems](https://rubygems.org/) installed. Then:

`gem install casento`

or if you just want to build and install locally:

```bash
git clone git@github.com:kueda/casento.git
cd casento
gem build casento.gemspec
gem install casento-x.x.x.gem
```

# Examples

`casento help` should get you started, but here are some ways I use it:

```bash
# List all records of Hemipenthes in California
casento checklist Hemipenthes --state California --country U.S.A.

# Export a checklist of all bee fly genera from California to CSV
casento checklist Bombyliidae --state California --country U.S.A. --rank genus -f csv > bombyliidae-genera-ca.csv
```
