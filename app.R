packrat::on();

require(shiny);
library(shiny);

envport <- Sys.getenv("PORT")
if (envport!="") {
    # this is required for heroku deployment. it appears that they coerce the port on their end
    runApp("sync_map", port=Sys.getenv(envport), host = getOption("shiny.host", "0.0.0.0"))
} else {
    runApp("sync_map", port=3838, host = getOption("shiny.host", "0.0.0.0"))
}