#!/usr/bin/bash

PROJECTNAME=prod
DOCKCOMP=docker-compose.prod.yml

FINALRUN=build/run.sh
FINALDOCKCOMP=build/docker-compose.yml

TEMP=tmp
DIST=dist

clean_dir () {
	rm -rf $1/; mkdir -p $1/
}

clean_dir $DIST
clean_dir $TEMP

docker-compose -p $PROJECTNAME -f $DOCKCOMP up --no-start --build &&

echo
count=$((count+1))

images=( $(docker-compose -p $PROJECTNAME -f $DOCKCOMP images | sed -r '2,2d' | awk -v col=Repository 'NR==1{for(i=1;i<=NF;i++){if($i==col){c=i;break}} print $c} NR>1{print $c}' | sed -r '1,1d') )
docker-compose -p $PROJECTNAME -f $DOCKCOMP rm -f &

for image in "${images[@]}"; do
	echo -e "Saving image $count/${#images[@]}: \e[32m$image\e[39m"
	docker save -o $TEMP/$image.tar $image
	count=$((count+1))
done

cp $FINALRUN $TEMP/run.sh 
cp $FINALDOCKCOMP $TEMP/docker-compose.yml 

tar -czf $DIST/$PROJECTNAME.tar.gz -C $TEMP .

rm -rf $TEMP
