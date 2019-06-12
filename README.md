## shinymap

### Who are we?
Code for Baltimore and members of the Baltimore tech/data community

### What is Sync the City?
A tool to connect organizations in Baltimore to improve impact

### Why are we making it?
Organizations don't know who is working on what and with whom

### Who is it meant for?
* Nonprofit leaders who need to collaborate to more effectively serve their communities
* Funding institutions who want to identify where they should invest their funds 

### How are we making it?
Shiny web application developed in R

### What does the application consist of?
* A map with the location of all nonprofit organizations in Baltimore City
* A table that reacts to filtering and tabulates organizations on the map
* A network graph of organizations and who they work with 

### Where are we getting this data from?
* We are currently using publically available data published by the IRS
* Some of our data model has been appended ourselves

### What are some major milestones to come?
* Deploying on a cloud service (GCP, AWS) and switching to a new domain name
* Building a database to allow for user input
* Re-assessing map design to account for where organizations work, not where they are
* Getting user feedback from using the tool as well as survey feedback

## Basic instructions to run local with docker

Requires:

- docker

Steps if using prebuilt:

1. `docker pull madhuravius/shinymap-baltimore`
2. `docker run -p 3838:3838 madhuravius/shinymap-baltimore`

Warning: Build takes > 30 minutes on an i5 8-threaded machine.

Steps if building:

1. `docker build -t shinymap-baltimore .`
2. `docker run -p 3838:3838 shinymap-baltimore`

Go to browser (http://localhost:3838) to access.

## Basic instructions on deploying image to heroku

1. Install heroku toolbelt
2. `heroku create` (store this somewhere, ex, personal one is: `mysterious-earth-28048`)
3. `heroku container:login`
4. Get the image id tag of the docker image (from pulling the docker image with `docker image ls` -- ex: `2890e2cb9de3`)
5. Tag the docker image: example based on image and tags: `docker tag 2890e2cb9de3 registry.heroku.com/mysterious-earth-28048/web` 
6. Push the docker image to heroku example based on image: `docker push registry.heroku.com/mysterious-earth-28048/web`
7. Release the image for use: `heroku container:release web --app mysterious-earth-28048`
8. `heroku open` to view it

My current docker build can be found here: https://mysterious-earth-28048.herokuapp.com

To view logs, follow it with `heroku logs`.
