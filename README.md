Spaced Repetition algorithm for Ruby. 

## Install
Add to your Gemfile:

    gem 'spaced_repetition', :git => 'git://github.com/espresse/spaced_repetition.git'

and run 

    bundle install

## Typical use-case:

    require 'rubygems'
    require 'spaced_repetition'

    #user's quality_response is 5, no previous repetition had been done yet
    sm2 = SpacedRepetition::Sm2.new(5) 

    #user's quality response is 3, his/her prevoius interval was 3 days and easiness factor was 2.1
    sm2 = SpacedRepetition::Sm2.new(3,3,2.1)

You can fetch results:

    #new interval
    new_interval = sm2.interval

    #new easiness_factor
    new_ef = sm2.easniness_factor

    #new repetition date
    new_date = sm2.next_repetition_date

By default, SM2, uses 6 possible answers (0-5), where 0 is very bad and 5 is perfect. If you want to use 4 answers (0 /very bad/ - 3 /perfect/) you can choose SM2Mod. It works in the same manner as SM2 does.

