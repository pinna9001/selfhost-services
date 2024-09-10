if [[ $# -ne 2 ]] ; then 
	echo "Usage:"
	echo "backup-audiobookshelf.sh <container_name> <paths_to_libraries>"
	echo "e.g. backup-audiobookshelf.sh audiobookshelf /books;/comics"
fi

container_name=$1
library_paths=$(echo $2 | tr ";" "\n")
backup_file="audiobookshelf-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

echo -n "Stopping docker container: "
docker container stop $container_name
echo "Done."

docker cp $container_name:/metadata/backups .

mkdir libraries
for library_path in $library_paths
do
	docker cp $container_name:$library_path libraries
done
tar -czf $backup_file backups libraries

rm -rf libraries
rm -rf backups

echo "Backup done "

echo -n "Starting docker contaier: "
docker container start $container_name
echo "Done."
