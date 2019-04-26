packrat::on();

require(shiny);
library(shiny);

runApp("sync_map", port=3838, host = getOption("shiny.host", "0.0.0.0"))