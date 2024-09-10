# audiobookshelf

## backups

Automatic backups should be enabled in the web interface (see `<server>/config/backups`).
The backupscript will then backup the backupfiles found on the server at `/metadata/backups` (the path specified as backup location) as well as all given libraries.

The backup script has to be called with the container name and the paths to the libraries as found inside of the container. (When you mount a directory `./books` as `/books` you have to specify `/books`; more library paths can be appended as well when seperated with `;` e.g. `/books;/lib/audiobooks`). 

For the docker-compose.yml file the backup command should look like this:

``` bash
audiobookshelf-backup.sh audiobookshelf /books
```

The backup will produce a tar.gz file with the following content:

``` 
-backups
  |-automatic backup from audiobookshelf 1
  |-automatic backup from audiobookshelf 2
-libraries
  |-library1
  |  |-audiobook folder structure
  |-library2
  |  |-ebook folder structure
```
