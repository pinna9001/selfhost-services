if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "homepage-backup.sh <container_name>"
	echo "e.g.homepage-backup.sh navidrome"
	exit 0
fi

container_name=$1
library_paths=$(echo $2 | tr ";" "\n")
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

echo -n "Stopping docker container: "
docker container stop $container_name
echo "Done."

docker cp $container_name:/app/config .
tar -czf $backup_file config

rm -rf config

echo "Backup done "

echo -n "Starting docker container: "
docker container start $container_name
echo "Done."

