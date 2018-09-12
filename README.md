#Bikeramp

First install all dependencies with:
> bundle install

Then create database and seed it with random data:
> rake db:setup

Now you can start server with:
> rails s

API includes two endpoints
>http://example.com/api/stats/weekly <br>
>http://example.com/api/stats/monthly ( monthly accepts two params: orderParam and orderType )

