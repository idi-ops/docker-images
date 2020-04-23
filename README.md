# docker-node-browsers

![CI](https://github.com/idi-ops/docker-node-browsers/workflows/Docker%20Image%20Push/badge.svg)

Fedora image with:

* Xvfb
* Firefox
* Chrome
* Node.js
* npm packages:
  * grunt-cli
  * nyc
  * testem

# Running

## Chrome

The [SYS_ADMIN](http://man7.org/linux/man-pages/man7/capabilities.7.html) capability is needed so that Chrome can create and switch into a new namespace for its sandbox environment:

```bash
$ docker run --cap-add=SYS_ADMIN inclusivedesign/node-browsers echo 'hello world'
```

If Chrome is not being used, `--cap-add=SYS_ADMIN` can be omitted as neither Firefox nor the Node.js tools seem to need that.

## UID/GID mapping

Commands executed inside a container run as a different user/group (usually root). To avoid issues with UID/GID mapping when sharing files with the host through volumes, you can specify the following environment variables (ALL need to be set for proper mapping):

 * `USER` - username
 * `USER_ID` - numeric user ID
 * `USER_GID` - numeric group ID

This is the default behavior (without UID/GID mapping):

```bash
host$ id 
uid=1000(user) gid=1000(user) groups=1000(user)

host$ docker run --rm -ti inclusivedesign/node-browsers id
uid=0(root) gid=0(root) groups=0(root)
```

And here you can see the proper user/group gets created inside the container if all 3 parameters are defined:

```bash
host$ docker run --rm -ti -e USER=$USER -e USER_ID=$(id -u) -e USER_GID=$(id -g) ${DOCKER_NODE_BROWSERS_IMAGE} id
uid=1000(user) gid=1000(user) groups=1000(user)
```
