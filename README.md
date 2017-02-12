# README

# Rails Engine

![image of rails engine api/v1/items](https://github.com/lsaville/readme-screenshots/blob/master/rails-engine/Screen%20Shot%202017-02-12%20at%208.31.10%20AM.png?raw=true)

Rails Engine is an example of an internal api that exposes csv data loaded through a rake task.

### Take it for a spin
###### One
Get the project <br>
`git clone git@github.com:dijital2016/rails_engine.git` 

###### Two
Install dependancies <br>
`bundle`

###### Three
Initiate database <br>
`rake db:create db:migrate`

###### Four
Load the data into the database <br>
`rake load_csv_files:all`

###### Five
Run the tests <br>
`rspec`


For the spec harness please visit
[here](https://github.com/turingschool/rales_engine_spec_harness) and follow the instructions posted
## Thanks!
[Dave](https://github.com/dijital2016) and [Lee](https://github.com/lsaville)
