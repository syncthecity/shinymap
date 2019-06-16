FROM syncthecity/syncthecity-base:latest

EXPOSE 3838
CMD ["Rscript", "/home/shinymap/app/app.R"]
