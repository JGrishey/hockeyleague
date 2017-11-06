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
image_file = image_file.convert(mode="L")

width, height = image_file.size

toa_away = (0.390625 * width, 0.4351851852 * height, 0.4270833333 * width, 0.467 * height)
toa_home = (0.7916666667 * width, 0.4351851852 * height, 0.828125 * width, 0.467 * height)
pp_away = (0.390625 * width, 0.5462962963 * height, 0.4270833333 * width, 0.5814814815 * height)
pp_home = (0.7916666667 * width, 0.5462962963 * height, 0.828125 * width, 0.5814814815 * height)

stats = []

import pytesseract

stat_dict = {
    "toa_h": image_file.crop((toa_home[0], toa_home[1], toa_home[2], toa_home[3])),
    "toa_a": image_file.crop((toa_away[0], toa_away[1], toa_away[2], toa_away[3])),
    "pp_h": image_file.crop((pp_home[0], pp_home[1], pp_home[2], pp_home[3])),
    "pp_a": image_file.crop((pp_away[0], pp_away[1], pp_away[2], pp_away[3]))
}

stats.append({
    "toa_h": pytesseract
            .image_to_string(
                stat_dict["toa_h"],
                config='-psm 8 -c tessedit_char_whitelist="0123456789:"'
            ),
    "toa_a": pytesseract
            .image_to_string(
                stat_dict["toa_a"],
                config='-psm 8 -c tessedit_char_whitelist="0123456789:"'
            ),
    "pp_h": pytesseract
            .image_to_string(
                stat_dict["pp_h"],
                config='-psm 8 -c tessedit_char_whitelist="0123456789/"'
            ),
    "pp_a": pytesseract
            .image_to_string(
                stat_dict["pp_a"],
                config='-psm 8 -c tessedit_char_whitelist="0123456789/"'
            )
})

for player in stats:
    for key,value in player.items():
        player[key] = "1" if value == "" else value
    
print(json.dumps(stats))