# shinymap

### Basic instructions to run local with docker

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