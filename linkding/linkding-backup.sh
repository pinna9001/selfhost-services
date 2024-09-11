if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "backup-audiobookshelf.sh <container_name>"
	echo "e.g. backup-audiobookshelf.sh linkding"
	exit 0
fi

container_name=$1
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

docker exec $container_name  python manage.py full_backup /etc/linkding/data/backup.zip
docker cp linkding:/etc/linkding/data/backup.zip ./backup.zip
tar -czf $backup_file backup.zip

rm backup.zip

echo "Backup done "
