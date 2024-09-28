if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "backup-baikal.sh <container_name>"
	echo "e.g. backup-baikal.sh baikal"
	exit 0
fi

container_name=$1
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

echo -n "Stopping docker container: "
docker container stop $container_name
echo "Done."

docker cp $container_name:/var/www/baikal/config .
docker cp $container_name:/var/www/baikal/Specific .
tar -czf $backup_file config Specific

rm -rf config Specific

echo "Backup done"

echo -n "Starting docker container: "
docker container start $container_name
echo "Done."

