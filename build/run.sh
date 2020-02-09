#!/usr/bin/bash

install () {
	echo
    echo "Removing old containers"
	docker rm -f $(docker ps -a -q)

	echo
    echo "Loading new images"
	count=$((var+1))
	images=($(ls ./*.tar))
	for filename in "${images[@]}"; do
		[ -e "$filename" ] || continue
    	echo -e "$count/${#images[@]} $(docker load -i $filename)"
		count=$((count+1))
	done

	echo
    echo "Starting application"
	docker-compose -p finished_build up -d
}

if docker -v; then
	install
else
    echo "Install docker"
fi
echo
read  -n 1 -p "Any key to continue..."