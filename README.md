# shinymap

### Basic instructions to run local with docker

Requires:

- docker

Steps if using prebuilt:

1. `docker pull madhuravius/shinymap-baltimore`
2. `docker run -p 3838:3838 madhuravius/shinymap-baltimore`

Steps if building:

1. `docker build -t shinymap-baltimore .`
2. `docker run -p 3838:3838 shinymap-baltimore`

Go to browser (http://localhost:3838)