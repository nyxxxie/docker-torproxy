# docker-torproxy
A super lightweight (image size is only ~15MB!) docker container designed to
be used as a proxy for other applications (irc, http, etc).  I'm currently
using it to scrape onion sites, and plan to use it with [black widow][1].

## Starting the container
```
docker run -d -p 9050:9050 
```

[1]: https://github.com/nyxxxie/blackwidow
