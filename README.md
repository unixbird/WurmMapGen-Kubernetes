# WurmMapGen-Kubernetes
Original WurmMapGen by woubuc made into a container image for Kubernetes Cronjobs

I noticed that there weren't any Container Images made for this and noticed that it would be simple to actually put together and run in my Kubernetes environment as a cronjob and then run a simple apache deployment to mount the output files so that's what I did!

### That being said this was made with the intent that it is running as a kubernetes cronjob. You could in theory run this in Docker however you wish but it is not its intent as it exits once the map is generated! It is also expected that you are running a seperate container to serve the html from the output

## Mount points

| Envar | Purpose |
| :----: | --- |
| `:/home/mapgen/wurmsave` | This is where your Wurm Unlimited map is stored. I run this as readonly in the example yaml provided. 
| `:/home/mapgen/wurmhttp` | This is the location where the mapgen outputs the html files necessary to serve your map on the net.

## Using with Kubernetes
In my example I use hostPaths as this is just deployed in a single node cluster. I have not tested it in a multi node cluster but its quite simple to deploy.
1. Either clone the repo and build the image yourself/push the the image to a registry OR deploy the example yaml.
2. To deploy simply run ```kubectl apply -f examplecronjob.yml```
3. The user inside the container is mapped to PUID/GUID 1000:1000. Make sure that this user is able to access the Wurm World. As long as the permissions are set it will run once every 24 hours and generate a new map!

## What about an apache server included?
I didn't want to make the image bigger than it needed to be and wanted to follow the "do one thing per container" philosophy. Fortunately apache is simple to deploy and I have a simple apache deployment example to serve the output that the WurmMapGen generates.

1. Download the apacheexample.yml or clone the repo and run ```kubectl apply -f apacheexample.yml``` after editing it to fit your needs and it should be deployed (this is assuming you have cert-manager and ingress-nginx already deployed and setup in your cluster.)
2. That's it. It should be serving the map once it's been deployed.

-------------------------------------------------------------
