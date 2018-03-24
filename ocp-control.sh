# Variables to control OCP functions

# update_<obj> determines whether or not modifications should be applied to the application objects in OpenShift.
# This will delete the route, deployment configuration, or the service, if set to yes and insert the object in the git repository.
export update_route=no
export update_service=no
export update_dc=yes
export project="examples"

if [ "$update_route" = "yes" ]; then
	echo "Replacing Route"
	/usr/local/bin/oc delete route basicphp -n $project
	/usr/local/bin/oc create -f route.json -n $project
fi
if [ "$update_service" = "yes" ]; then
        echo "Replacing Service"
        /usr/local/bin/oc delete service basicphp -n $project
        /usr/local/bin/oc create -f service.json -n $project
fi
if [ "$update_dc" = "yes" ]; then
        echo "Replacing DeploymentConfig"
        /usr/local/bin/oc delete dc/basicphp -n $project
        /usr/local/bin/oc create -f deploymentconfig.json -n $project
else
	echo "Deploying Application"
	/usr/local/bin/oc rollout latest dc/basicphp -n $project
fi
