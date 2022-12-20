import re
import glob
import socket
import fiftyone as fo

DATA = 'mine'


if DATA == 'mine':
    SPLIT = 'val'
    DATASET_DIR = "../datasets/instances_train2017_yolov5"

    dataset = fo.Dataset.from_dir(
        dataset_dir=DATASET_DIR,
        dataset_type=fo.types.YOLOv5Dataset,
        split=SPLIT
    )

    # CONF = '01502' if SPLIT == 'val' else '02803'
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'conf01502_iou45',
    # f'runs/detect/instances_train2017_yolov5/exp_test_mine_hyp_tuned_2_2022-07-07_12:16:51/{SPLIT}/conf{CONF}_iou45/labels'
    # )
    fo.utils.yolo.add_yolo_labels(
        dataset,
        'initial_conf002_iou45',
        f'runs/detect/instances_train2017_yolov5/exp_test_mine_hyp_tuned_agnosticNMS_2022-07-09_17:10:56/val/conf002_iou45/labels'
    )
    fo.utils.yolo.add_yolo_labels(
        dataset,
        'lowtuned_conf001_iou45',
        f'runs/detect/instances_train2017_yolov5/exp_test_mine_obj_pw=0_01_obj=1_2022-07-13_03:32:48/val/conf001_iou45/labels'
    )
    fo.utils.yolo.add_yolo_labels(
        dataset,
        'tuned_conf001_iou45',
        f'runs/detect/instances_train2017_yolov5/exp_test_mine_lr0=0_005_lrf=0_05_momentum=0_997_Adam_2022-07-24_23:03:25/val/conf001_iou45/labels'
    )

else:
    SPLIT = 'train'
    DATASET_DIR = "../datasets/MoNuSeg_train2021_yolov5"

    dataset = fo.Dataset.from_dir(
        dataset_dir=DATASET_DIR,
        dataset_type=fo.types.YOLOv5Dataset,
        split=SPLIT
    )

    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann100p',
    # 'runs/detect/MoNuSeg_train2021_yolov5/exp_2022-06-14_20:54:36_train_hyp_med_obj_pw=0_1_obj=1/test/conf09009_iou50/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann50p',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=50p_yolov5/exp_2022-06-14_20:55:35_train_hyp_med_obj_pw=0_1_obj=1/test/conf03103_iou45/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann25p',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=25p_yolov5/exp_2022-06-16_11:54:24_train_hyp_med_obj_pw=0_1_obj=1/test/conf01502_iou40/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann10p',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=10p_yolov5/exp_2022-06-16_11:54:34_train_hyp_med_obj_pw=0_1_obj=1/test/conf00501_iou20/labels'
    # )

    # TTA
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann100p_tta',
    # 'runs/detect/MoNuSeg_train2021_yolov5/exp_2022-06-14_20:54:36_train_hyp_med_obj_pw=0_1_obj=1/test/conf09009_iou50_tta/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann50p_tta',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=50p_yolov5/exp_2022-06-14_20:55:35_train_hyp_med_obj_pw=0_1_obj=1/test/conf03103_iou45_tta/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann25p_tta',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=25p_yolov5/exp_2022-06-16_11:54:24_train_hyp_med_obj_pw=0_1_obj=1/test/conf01502_iou40_tta/labels'
    # )
    #
    # fo.utils.yolo.add_yolo_labels(
    # dataset,
    # 'ann10p_tta',
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=10p_yolov5/exp_2022-06-16_11:54:34_train_hyp_med_obj_pw=0_1_obj=1/test/conf00501_iou20_tta/labels'
    # )

    # 'runs/detect/MoNuSeg_train2021_yolov5/exp_2022-06-14_20:54:36_train_hyp_med_obj_pw=0_1_obj=1/test/conf09009_iou50/labels'
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=50p_yolov5/exp_2022-06-14_20:55:35_train_hyp_med_obj_pw=0_1_obj=1/test/conf03103_iou45/labels'
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=25p_yolov5/exp_2022-06-16_11:54:24_train_hyp_med_obj_pw=0_1_obj=1/test/conf01502_iou40/labels'
    # 'runs/detect/MoNuSeg_train2021_seed=0_img=100p_ann=10p_yolov5/exp_2022-06-16_11:54:34_train_hyp_med_obj_pw=0_1_obj=1/test/conf00501_iou20/labels'

    # detections = glob.glob('runs/detect/*/*/*')

    # for detection in detections:
    #     p = re.findall('ann=\d+', detection) or ['ann=100']
    #     name = p[0] + '_' + re.findall('conf\d+_(iou\d+)', detection)[0]
    #     print('Found', name)
    #     fo.utils.yolo.add_yolo_labels(
    #         dataset,
    #         name,
    #         detection
    #     )

session = fo.launch_app(dataset, port=5153)
session.wait()
