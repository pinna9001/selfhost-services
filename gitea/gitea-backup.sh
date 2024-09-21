if [[ $# -ne 1 ]] ; then 
	echo "Usage:"
	echo "backup-gitea.sh <container_name>"
	echo "e.g. backup-gitea.sh gitea"
	exit 0
fi

container_name=$1
backup_file="$container_name-backup-$(date +"%d%m%Y-%H%M%S").tar.gz"

docker exec -it -u git -w /tmp $container_name /bin/bash -c "rm -rf /tmp/gitea-dump-*.zip"
docker exec -it -u git -w /tmp $container_name /bin/bash -c "/usr/local/bin/gitea dump -c /data/gitea/conf/app.ini"
docker cp $container_name:/tmp ./backups
find . -mindepth 1 ! -name "gitea-dump-*.zip" -exec rm -r {} \;
tar -czf $backup_file ./backups/gitea-dump-*.zip

rm -rf ./backups

echo "Backup done"
