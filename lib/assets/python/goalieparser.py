from PIL import Image
import argparse
import requests
import json
from io import BytesIO
import base64

parser = argparse.ArgumentParser(description='Get URL')
parser.add_argument('--image')

args = parser.parse_args()

image = BytesIO(base64.b64decode(args.image))

import numpy as np

image_file = Image.open(image)
image_file = image_file.convert(mode="L").resize((3840, 2160))

width, height = image_file.size

name_dim = (0.04947916667 * width, 0.234375 * width)
toi_dim = (0.234375 * width, 0.2682291667 * width)
sa_dim = (0.2942708333 * width, 0.3385416667 * width)
ga_dim = (0.4765625 * width, 0.5208333333 * width)
g_dim = (0.7682291667 * width, 0.796875 * width)
a_dim = (0.8203125 * width, 0.8463541667 * width)

goalie_stats = []

import pytesseract

diff = 0.03888888889

for x in np.arange(0.2407407407 * height, 0.2796296296 * height, diff*height):
    
    stat_dict = {
        "name": image_file.crop((name_dim[0], x, name_dim[1], x+diff*height)),
        "toi": image_file.crop((toi_dim[0], x, toi_dim[1], x+diff*height)),
        "sa": image_file.crop((sa_dim[0], x, sa_dim[1], x+diff*height)),
        "ga": image_file.crop((ga_dim[0], x, ga_dim[1], x+diff*height)),
        "g": image_file.crop((g_dim[0], x, g_dim[1], x+diff*height)),
        "a": image_file.crop((a_dim[0], x, a_dim[1], x+diff*height)),
    }

    
    goalie_stats.append({
        "name": pytesseract
                .image_to_string(
                    stat_dict["name"],
                    config='-c tessedit_char_whitelist="AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz."'
                ),
        "toi": pytesseract
                .image_to_string(
                    stat_dict["toi"],
                    config='-c tessedit_char_whitelist="0123456789:"'
                ),
        "sa": pytesseract
                .image_to_string(
                    stat_dict["sa"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "ga": pytesseract
                .image_to_string(
                    stat_dict["ga"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "g": pytesseract
                .image_to_string(
                    stat_dict["g"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "a": pytesseract
                .image_to_string(
                    stat_dict["a"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                )
    })
    
goalie_stats = list(filter(lambda x: x["toi"] != "00:00", goalie_stats))

for player in goalie_stats:
    player.pop("toi", 0)
    for key,value in player.items():
        player[key] = "1" if value == "" else value

print(json.dumps(goalie_stats))