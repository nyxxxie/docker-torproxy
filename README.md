# docker-torproxy
Need a quick tor proxy for IRC, scraping, or some other purpose?  This image
sets up a fully functional tor proxy in 15mb.  The image itself is extremely
lightweight and easy to understand; it simply runs tor on alpine linux using
the torrc config file located in this repo.  Feel free to fork and modify the
config if you need any of the other features that tor provides.

## Starting the container

### From Dockerhub
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

### Python (tested with 3.6)
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
