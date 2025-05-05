import os, sys

sys.path.append(os.path.join(os.environ['alfred_preferences'], 'workflows'))

import urllib.parse
import hashlib

import url_normalize

import alfred

urls = set()

class Item(dict):
    @staticmethod
    def normalize_netloc(netloc):
        netloc_parts = netloc.split(".")

        if len(netloc_parts) == 2:
            netloc_parts.insert(0, "www")

        return ".".join(netloc_parts)

    def __init__(self, title, url, description = "", tags = ""):
        urlNormalized = url_normalize.url_normalize(url)
        [scheme, netloc, path, query, fragment] = urllib.parse.urlsplit(urlNormalized)
        scheme = "https"

        if netloc.startswith("javascript"):
            return

        netloc = self.normalize_netloc(netloc)

        urlNormalized1 = urllib.parse.urlunsplit(
                (scheme, netloc, path, query, fragment)
                )

        if urlNormalized1 in urls:
            return
        else:
            urls.add(urlNormalized1)

        guid = hashlib.md5(url.encode()).hexdigest()

        self["title"] = title
        self["uid"] = f"url.{guid}"
        self["match"] = alfred.match_terms(f"{tags} {title} {description} {netloc}")
        self["arg"] = url
        self["subtitle"] = urlNormalized1
