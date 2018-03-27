# Basic PHP

This is a test application to deploy in to OpenShift. 

### Deploying via TeamCity

Make sure the oc cli utility for OpenShift is installed and extracted /usr/local/bin.
Create a Project with 1 or 2 build steps. The runner type needs to be "Command Line" and use a Custom Script.

#### Step 1

```
#!/bin/bash
VERSION="1.0.0.${BUILD_NUMBER:-99}"
sed -i "s/@VERSION@/${VERSION}/g" index.php
IMAGE=factory:8081/docker-local/basicphp2
ID=$(docker build  -t ${IMAGE}  .  | tail -1 | sed 's/.*Successfully built \(.*\)$/\1/')

docker tag ${ID} ${IMAGE}:${VERSION}
docker tag ${ID} ${IMAGE}:latest

docker push ${IMAGE}:${VERSION}
docker push ${IMAGE}:latest

docker rmi ${IMAGE}:${VERSION}
docker rmi ${IMAGE}:latest
```

#### Step 2

You do not have to use the ocp-control.sh script, you can simply run:

```
 /usr/local/bin/oc rollout --latest basicphp -n <project>
```

The token should be a for a service account that has limited access to modify / create / delete objects.

```
#!/bin/bash
VERSION="1.0.0.${BUILD_NUMBER:-99}"
sed -i "s/@VERSION@/$VERSION/g" deploymentconfig.json
/usr/local/bin/oc login --token='<token>' --insecure-skip-tls-verify=true https://openshift.<fqdn>:8443
bash ocp-control.sh
```


