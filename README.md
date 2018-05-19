# docker-torproxy
A super lightweight (image size is only ~15MB!) docker container designed to
be used as a proxy for other applications (irc, http, etc).  I'm currently
using it to scrape onion sites, and plan to use it with [black widow][1].

## Starting the container

### From dockerhub
TODO: set this up

### From cloned repo
```
docker build -t torproxy .
docker run -d -p 9050:9050 torproxy
```

## Using the proxy

### curl
```
# curl >= 7.21.7
curl -x socks5h://localhost:9050 https://3g2upl4pq6kufc4m.onion/
# curl >= 7.18.0
curl --socks5-hostname localhost:9050 https://3g2upl4pq6kufc4m.onion/

# NOTE: the 'hostname' and 'socks5h' in both commands make sure we do dns
#       lookups through the specified socks5 proxy (in other words, through
#       tor).  This'll make sure we properly resolve onion links as well as
#       anonymize clearnet lookups.
```

### python
```
import requests

s = requests.session()

# Obfuscate user agent (Mozilla/5.0 is super common)
s.headers = {
    'User-Agent': 'Mozilla/5.0'
}

# Route requests through tor
s.proxies = {
    'http':  'socks5h://localhost:9050',
    'https': 'socks5h://localhost:9050',
}

# Fetch the page
r = s.get('https://3g2upl4pq6kufc4m.onion/')
print(r.text)
print(r.status_code)
```

[1]: https://github.com/nyxxxie/blackwidow
