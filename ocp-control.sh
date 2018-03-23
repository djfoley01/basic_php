# Variables to control OCP functions

# update_obj determines whether or not modifications should be applied to the application objects in OpenShift.
# This will replace the route and deployment configuration settings, and delete then re-create the service if set to yes
export update_obj=yes

if [ "$update_obj" = "no" ]; then
	/usr/local/bin/oc rollout latest dc/basicphp -n examples
else
	echo "Replacing Objects"
	/usr/local/bin/oc replace -f route.json -n examples
fi
