if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "backup-freshrss.sh <container_name>"
	echo "e.g. backup-freshrss.sh freshrss"
	exit 0
fi

container_name=$1
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

echo -n "Stopping docker container: "
docker container stop $container_name
echo "Done."

docker cp $container_name:/var/www/FreshRSS .

tar -czf $backup_file FreshRSS

rm -rf FreshRSS

echo "Backup done "

echo -n "Starting docker contaier: "
docker container start $container_name
echo "Done."

