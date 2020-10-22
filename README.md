# OGS KataCheck

This CLI gem is intended to aid OGS team members in the investigation of suspected AI cheaters.

It pulls game information from the OGS API and checks the user submitted moves against full reviews run on the game.

## Installation

You will need to have Ruby installed on your machine to run this CLI. If you are using a Mac, this is already done for you. If on a Windows machine you can install it by following [these instructions](https://stackify.com/install-ruby-on-windows-everything-you-need-to-get-going/).

To install this Gem, open a terminal and run:

    $ gem install ogs_katacheck

## Usage

After installing OGS KataCheck, you can run it by opening a terminal and typing:

    $ ogs-katacheck

You will be asked to enter a game ID. This can be simply copied and pasted from OGS.

You will then be presented with a list of available OGS AI reviews. **Only full reviews** are useable with this tool.  If you do not see a full review in the list, open the game in OGS and run a full review. Once the server has completed the review, re-run the tool.

The tool will output the number of user submitted moves that match the top 4 moves suggested by the AI in the review. Obviously, `tier 1` and `tier 2` moves are most important to look at, but the overall percentages can also be helpful.

***Note:** A high percentage match in a game does not necessarily mean the user is cheating, but high percentage matches across many games will certainly warrant further investigation.*

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubymineshaft/ogs_katacheck.
