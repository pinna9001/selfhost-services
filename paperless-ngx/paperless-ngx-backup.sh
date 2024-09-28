if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "paperless-ngx-backup.sh <container_name>"
	echo "e.g. paperless-ngx-backup.sh paperless-ngx"
	exit 0
fi

container_name=$1
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

echo -n "Stopping docker container: "
docker container stop $container_name
echo "Done."

docker cp $container_name:/usr/src/paperless/data .
docker cp $container_name:/usr/src/paperless/media .

tar -czf $backup_file data media

rm -rf data media

echo "Backup done "

echo -n "Starting docker contaier: "
docker container start $container_name
echo "Done."


