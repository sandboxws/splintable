= Splintable

Splintable is a simple readable ruby component similar to Pocket and Readability.

== Install

Add to Gemfile

```ruby
gem 'splintable', git: 'https://github.com/sandboxws/splintable.git'
```

== Usage

```ruby
# build the readable object
readable = Splintable.readable 'http://tnw.to/r1p7'

# the title of the webpage
readable.title

# the inner text of the first paragraph of the main content of this link
readable.description

# a hash of images links grouped under two keys, "cover_image" and "post"
readable.images

# Display HTML raw content of the main content of this link which is the article itself
readable.raw_content
```

== Contributing to splintable
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2013 Ahmed El.Hussaini. See LICENSE.txt for further details.
