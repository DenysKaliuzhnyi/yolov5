import fiftyone as fo


DATASET_DIR = "../datasets/MoNuSeg_train2021_yolov5"
SPLIT = 'val'

dataset = fo.Dataset.from_dir(
    dataset_dir=DATASET_DIR,
    dataset_type=fo.types.YOLOv5Dataset,
    split=SPLIT
)

fo.utils.yolo.add_yolo_labels(
    dataset,
    "test_pred_full",
    f"runs/detect/MoNuSeg_train2021_yolov5/{SPLIT}set_baseline2/labels",
)

fo.utils.yolo.add_yolo_labels(
    dataset,
    "test_pred_50pct",
    f"runs/detect/MoNuSeg_train2021_seed0_img100p_ann50p_yolov5/{SPLIT}set_baseline2/labels/",
)

session = fo.launch_app(dataset, port=5151)

session.wait()
