import json
import urllib.request
import time


def main():
    while True:
        with urllib.request.urlopen("https://api.bitflyer.com/v1/getticker") as response:
            data = json.load(response)
        print(data)

        time.sleep(1.0)
