#!/bin/bash

# Activate your environment
source env_fiftyone/bin/activate

YAML_PATH=data/MoNuSeg_train2021_yolov5.yaml
DATASET_PATH=../datasets/MoNuSeg_train2021_yolov5/images/
LABELS_PATH=../datasets/MoNuSegs_train2021_yolov5/labels/
DATASET_DIR="/tmp/MoNuSeg_train2021_yolov5"

# View the dataset in the App
#fiftyone app view --type fiftyone.types.YOLOv5Dataset --dataset-dir $DATASET_DIR
python launch_fiftyone.py

echo "DONE"