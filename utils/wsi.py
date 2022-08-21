import re
import json
import datetime


coco_json = {
    "info": {
        "year": "2022",
        "version": "1.0",
        "description": "Cell object detection predictions on WSI testis data",
        "contributor": "BIIT research group at University of Tartu",
        # "url": "",
        "date_created": datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    },
    "licenses": [],
    "categories": [
        {
            "id": 1,
            "name": "Spermatogonia",
            "supercategory": "cell"
        },
        {
            "id": 2,
            "name": "Sertoli",
            "supercategory": "cell"
        },
        {
            "id": 3,
            "name": "Primary spermatocyte",
            "supercategory": "cell"
        },
        {
            "id": 4,
            "name": "Spermatid",
            "supercategory": "cell"
        },
        {
            "id": 5,
            "name": "Spermatozoa",
            "supercategory": "cell"
        },
        # {
        #     "id": 6,
        #     "name": "Garbage cell",
        #     "supercategory": "cell"
        # }
    ],
    "images": [],
    "annotations": []
}


def assemble_annotations(labels_path, img_size):
    wsi_cache = {}  # to log image id
    img_cnt = 0  # to rank image id
    ann_cnt = 0  # to rank annotation id

    # iterate through annotation files (per crop)
    for p in labels_path.glob('*.txt'):
        stem = p.stem

        # restore WSI info from annotation file name
        wsix = int(re.findall(r'x=(\d+)', stem)[0])
        wsiy = int(re.findall(r'y=(\d+)', stem)[0])
        wsiname = re.findall(r'(.*)_x=', stem)[0] + '.mrxs'

        # get corresponding WSI id or create otherwise
        img_id = wsi_cache.get(wsiname)
        if img_id is None:
            img_id = img_cnt
            wsi_cache[wsiname] = img_id

            wsi = {
                # "coco_url": ""
                "id": img_id,
                # "license": 1,
                "file_name": wsiname,
                "width": img_size[0],
                "height": img_size[1],
                # "date_captured": "",
                # "flickr_url": ""
            }
            img_cnt += 1

            coco_json['images'].append(wsi)

        # iterate through annotations
        content = p.read_text().strip()
        for line in content.split('\n'):
            cid, cx, cy, cw, ch, cc_ = list(map(float, line.split()))

            # scale coordinates from yolo to coco format and adjust to WSI coordinate system
            bbox = (img_size[0] * (cx - cw / 2) + wsix,
                    img_size[1] * (cy - ch / 2) + wsiy,
                    img_size[0] * cw,
                    img_size[1] * ch)
            bbox = list(map(lambda x: int(round(x)), bbox))
            area = bbox[2] * bbox[3]
            ann_id = ann_cnt

            annotation = {
                "id": ann_id,
                "image_id": img_id,
                "category_id": cid,
                "bbox": bbox,
                "area": area,
                "iscrowd": 0,
                # "segmentation": []
            }
            ann_cnt += 1

            coco_json["annotations"].append(annotation)

    # save as a single json file
    coco_save_path = labels_path.parent / 'wsi_prediction.json'
    with coco_save_path.open('w') as f:
        json.dump(coco_json, f, indent=4)
