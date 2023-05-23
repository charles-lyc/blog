import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

prefix = '''---
title: Gallery
albums: [
'''

postfix = '''
        ["thumbnail_url","gallery/1.gif","img_caption"]
        ]
---
'''

def get_sorted_image_names(folder_path):
    image_extensions = [".jpg", ".jpeg", ".png", ".bmp",".gif",".webp"]
    image_names = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            if file.lower().endswith(tuple(image_extensions)):
                image_names.append(file)
    image_names.sort()
    return image_names

folder_path = "images"
image_names = get_sorted_image_names(folder_path)
with open("index.md", "w") as f:
    f.write(prefix)
    for name in image_names:
        formatted_string = f'''        ["thumbnail_url","gallery/images/{name}","img_caption"],\n'''
        f.write(formatted_string)
    f.write(postfix)
