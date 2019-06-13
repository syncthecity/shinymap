FROM sleyva97/shinymap-base:latest

EXPOSE 3838
CMD ["Rscript", "/home/shinymap/app/app.R"]
