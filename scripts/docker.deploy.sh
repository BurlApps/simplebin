#!/bin/bash

OUTPUT="\n"

# Build New Image
docker build -t bvallelunga/enjoypnd .

# Run New Images
if [ -z "$1" ]; then
  docker run -p 3000:3000 -d bvallelunga/enjoypnd
  OUTPUT="$OUTPUT\nDevelopment - http://$(boot2docker ip):3000"
else
  for i in $(echo $1 | tr "," "\n"); do
    if [ "$i" == "dev" ] || [ "$i" == "both" ]; then
      docker run -p 3000:3000 -d bvallelunga/enjoypnd
      OUTPUT="$OUTPUT\nDevelopment - http://$(boot2docker ip):3000"
    fi

    if [ "$i" == "prod" ] || [ "$i" == "both" ]; then
      docker run -p 80:3000 -d -e NODE_ENV=production bvallelunga/enjoypnd
      OUTPUT="$OUTPUT\nProduction - http://$(boot2docker ip)"

    elif [ "$i" != "dev" ]; then
      docker run -p $i:3000 -d bvallelunga/enjoypnd
      OUTPUT="$OUTPUT\nDevelopment - http://$(boot2docker ip):$i"
    fi
  done
fi

echo -e $OUTPUT
