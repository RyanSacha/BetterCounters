# Better Counters
==============

### Description

Counter cache is a great feature in Rails ActiveRecord to improve counting performance of a model's child associations by caching the number in a column.

Unfortunately it is tied to `belongs_to`, Many times i had to create similar custom methods from scratch just to work with `delegate` or simply shortcut methods or models that aren't associated through `belongs_to`

Here comes Better Counters with an independent syntax.

### Installation

In your Gemfile add this line:

    gem 'better_counters'

Run `bundle install`

### Usage

In the following examples, we assume that we have a model `User` that has many `Project`s and many `Task`s through projects, and we'd like to cache the tasks count on the `User` model.

First you need to create a migration and add a counter column, like `tasks_count`.

    rails g migration AddTasksCountToUsers

Open up the generated migration file located at `/db/migrate/XXXXX.rb` and replace the content with something like:

    def self.up
      add_column :users, :tasks_count, :integer, :default => 0

      # Fill in the new cache column with each user's tasks count
      User.reset_column_information
      User.find(:all).each do |p|
        User.update_counters p.id, :tasks_count => p.tasks.count
      end
    end

    def self.down
      remove_column :user, :tasks_count
    end

Run `rake db:migrate`

Then simply on your model add the method `counter_cache` with a hash of models to keep the count column in.

    class Task < ActiveRecord::Base
      belongs_to :project
      counter_cache :user => true

      def user
        project.user
      end
    end

Based on the example above, to fetch a user's total tasks count, run: `@user.tasks_count`.
You will no longer have to use the slow `@user.tasks.count`

You can use the counter cache in multiple models as long as they all have a counter column.

    counter_cache :user => true, :project => true

### Custom counter column names

You can override the default column name with your own:

    counter_cache :user => :total_tasks

* * *

![God of the Internet](http://i.imgur.com/ETKp5.jpg)

* * *

### Contributing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

**Copyright**

Copyright (c) 2012 Ryan Sacha. See LICENSE.txt for
further details.

If you happen to be bored, You can check out my [Portfolio](http://ryansacha.com).