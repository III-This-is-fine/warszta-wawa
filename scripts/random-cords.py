import dataclasses
from dataclasses import dataclass
import json
import random
import requests


@dataclass
class LatLng:
    lat: float
    lng: float


# Warsaw coordinates
lat_min = 52.1348782
lat_max = 52.3219161
lon_min = 20.8023824
lon_max = 21.2087757


def random_coordinates():
    return LatLng(
        lat=random.uniform(lat_min, lat_max),
        lng=random.uniform(lon_min, lon_max)
    )


N = 700
workshops = [random_coordinates() for _ in range(N)]


class EnhancedJSONEncoder(json.JSONEncoder):
    def default(self, o):
        if dataclasses.is_dataclass(o):
            return dataclasses.asdict(o)
        return super().default(o)


# print(json.dumps(workshops, cls=EnhancedJSONEncoder, indent=2))

key = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa"

url = "https://maps.googleapis.com/maps/api/geocode/json?latlng={},{}&key=" + key

district = "sublocality_level_1"


def get_address(lat, lng):
    response = requests.get(url.format(lat, lng))
    data = response.json()
    _district = [x for x in data["results"][0]["address_components"] if district in x['types']]
    return (lat, lng), data["results"][0]["formatted_address"], _district


print("addresses = {")
for workshop in workshops:
    coord, address, districts = get_address(workshop.lat, workshop.lng)
    if not districts:
        continue
    dist_name = districts[0]["long_name"]
    print(f"    '{address}': ('{dist_name}', {coord}),")
print("}")
