from PIL import Image 
import argparse
import requests
import json
from io import BytesIO
import base64

parser = argparse.ArgumentParser(description='Get URL')
parser.add_argument('--image')

args = parser.parse_args()

image = BytesIO(base64.b64decode(open(args.image).read()))

import numpy as np

image_file = Image.open(image)
image_file = image_file.convert(mode="L").resize((3840, 2160))

width, height = image_file.size

name_dim = (0.05208333333 * width, 0.234375 * width)
toi_dim = (0.234375 * width, 0.2682291667 * width)
g_dim = (0.2916666667 * width, 0.3285416667 * width)
a_dim = (0.3385416667 * width, 0.3958333333 * width)
s_dim = (0.5 * width, 0.5520833333 * width)
pim_dim = (0.6041666667 * width, 0.6770833333 * width)
hits_dim = (0.6770833333 * width, 0.7239583333 * width)
ppg_dim = (0.7239583333 * width, 0.7760416667 * width)
shg_dim = (0.7760416667 * width, 0.828125 * width)
fot_dim = (0.828125 * width, 0.8802083333 * width)
fow_dim = (0.8802083333 * width, 0.9322916667 * width)

stats = []

import pytesseract

diff = 0.03888888889

for x in np.arange(0.2407407407 * height, 0.7037037037 * height, diff*height):
    
    stat_dict = {
        "name": image_file.crop((name_dim[0], x, name_dim[1], x+diff*height)),
        "toi": image_file.crop((toi_dim[0], x, toi_dim[1], x+diff*height)),
        "g": image_file.crop((g_dim[0], x, g_dim[1], x+diff*height)),
        "a": image_file.crop((a_dim[0], x, a_dim[1], x+diff*height)),
        "s": image_file.crop((s_dim[0], x, s_dim[1], x+diff*height)),
        "pim": image_file.crop((pim_dim[0], x, pim_dim[1], x+diff*height)),
        "hits": image_file.crop((hits_dim[0], x, hits_dim[1], x+diff*height)),
        "ppg": image_file.crop((ppg_dim[0], x, ppg_dim[1], x+diff*height)),
        "shg": image_file.crop((shg_dim[0], x, shg_dim[1], x+diff*height)),
        "fot": image_file.crop((fot_dim[0], x, fot_dim[1], x+diff*height)),
        "fow": image_file.crop((fow_dim[0], x, fow_dim[1], x+diff*height)),
    }

    
    stats.append({
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
        "g": pytesseract
                .image_to_string(
                    stat_dict["g"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "a": pytesseract
                .image_to_string(
                    stat_dict["a"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "shots": pytesseract
                .image_to_string(
                    stat_dict["s"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "pim": pytesseract
                .image_to_string(
                    stat_dict["pim"],
                    config='-c tessedit_char_whitelist="0123456789:"'
                ),
        "hits": pytesseract
                .image_to_string(
                    stat_dict["hits"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "ppg": pytesseract
                .image_to_string(
                    stat_dict["ppg"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "shg": pytesseract
                .image_to_string(
                    stat_dict["shg"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "fot": pytesseract
                .image_to_string(
                    stat_dict["fot"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                ),
        "fow": pytesseract
                .image_to_string(
                    stat_dict["fow"],
                    config='-psm 8 -c tessedit_char_whitelist="0123456789"'
                )
    })
    
stats = list(filter(lambda x: x["toi"] != "00:00", stats))

for player in stats:
    player.pop("toi", 0)
    for key,value in player.items():
        player[key] = "1" if value == "" else value

print(json.dumps(stats))