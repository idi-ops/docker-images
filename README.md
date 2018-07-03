# docker-node-browsers

Fedora 28 image with:

* Firefox
* Chrome
* Node.js
* npm packages:
  * grunt-cli
  * istanbul
  * testem

# Running

The [SYS_ADMIN](http://man7.org/linux/man-pages/man7/capabilities.7.html) capability is needed so that Chrome can create and switch into a new namespace for its sandbox environment.

```bash
$ docker run --cap-add=SYS_ADMIN inclusivedesign/node-browsers  
```

If Chrome is not being used, `--cap-add=SYS_ADMIN` can be omitted neither Firefox or the Node.js tools seem to need that.
