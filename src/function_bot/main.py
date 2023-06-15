import json
import urllib.request


def main():
    with urllib.request.urlopen("https://api.bitflyer.com/v1/getticker") as response:
        data = json.load(response)
    print(data)
