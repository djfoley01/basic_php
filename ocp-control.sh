# Variables to control OCP functions

# update_<obj> determines whether or not modifications should be applied to the application objects in OpenShift.
# This will delete the route, deployment configuration, or the service, if set to yes and insert the object in the git repository.
export update_route=no
export update_service=no
export update_dc=no

if [ "$update_route" = "yes" ]; then
	echo "Replacing Route"
	/usr/local/bin/oc delete route basicphp -n examples
	/usr/local/bin/oc create -f route.json -n examples
fi
if [ "$update_service" = "yes" ]; then
        echo "Replacing Service"
        /usr/local/bin/oc delete service basicphp -n examples
        /usr/local/bin/oc create -f service.json -n examples
fi
if [ "$update_dc" = "yes" ]; then
        echo "Replacing DeploymentConfig"
        /usr/local/bin/oc delete dc/basicphp -n examples
        /usr/local/bin/oc create -f deploymentconfig.json -n examples
else
	echo "Deploying Application"
	/usr/local/bin/oc rollout latest dc/basicphp -n examples
fi
