#this file generates yml file

#!/bin/bash
set -e
start=`date +%s`

# SWAGGER-CODEGEN
GITCODEGEN=https://github.com/swagger-api/swagger-codegen.git
if [ -d "swagger-codegen" ]; then	
	cd swagger-codegen
	#echo "Updating ${GITCODEGEN} to swagger-codegen/..."
	#git pull .
else
	echo "Cloning ${GITCODEGEN} to swagger-codegen/..."
	git clone ${GITCODEGEN}
	cd swagger-codegen
	echo "running `./run-in-docker.sh mvn package`"
	./run-in-docker.sh mvn package	
fi

outdir="../out/" #add a trailing /

mkdir -p $outdir

name="RebuildEQ"
ymlfile="rebuildeq.yml"


cp ../$ymlfile tmp.yml
echo "Creating documentation for $name in $outdir"
./run-in-docker.sh generate -i tmp.yml -l html2 -o out/html/ -Dpackagename=dilectus
cp out/html/index.html $outdir

languages=("csharp" "cpprest" "go" "java" "javascript" "objc" "php" "python" "ruby" "python-flask")


mkdir -p ${outdir}sdk
rm -rf out/sdk/*
echo "Creating SDKs for $name in ${outdir}sdk/..."
for lang in "${languages[@]}"; do	
	./run-in-docker.sh generate -i tmp.yml -l $lang -o /gen/out/sdk/$lang/ -Dpackagename=dilectus
	zip -r out/sdk/$lang.zip out/sdk/$lang
	mv out/sdk/$lang.zip ${outdir}sdk/$lang.zip
done
rm tmp.yml

cd ..
# SWAGGER-UI
GITCODEGEN=https://github.com/swagger-api/swagger-ui.git
if [ -d "swagger-ui" ]; then	
	cd swagger-ui
	#echo "Updating ${GITCODEGEN} to swagger-codegen/..."
	#git pull .
else
	echo "Cloning ${GITCODEGEN} to swagger-ui/..."
	git clone ${GITCODEGEN}
	cd swagger-ui
	echo "Installing NPM dependencies..."
	npm install .
fi

echo "Building swagger-ui..."
npm build .

echo "Copying $ymlfile from root to ${outdir}..."
cp ../$ymlfile $outdir
cd ../swagger-codegen
cd ..

echo "Copying all files (minus index.html) to ${outdir}interactive/..."
for f in dist/* ; do 
	if [ -f "$f" ] && "$f" != "${outdir}/interactive/index.html" ]; then
		cp $f {$outdir}/interactive/
		echo $f...
	fi
done
end=`date +%s`
runtime=$((end-start))
echo "Completed in ${runtime} seconds"