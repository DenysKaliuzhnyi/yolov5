#!/bin/bash
# The name of the job is
#SBATCH -J detect_wsi

# Format of the output filename
#SBATCH -o slurm-out/slurm-%j.out

#SBATCH --cpus-per-task=8

# The maximum walltime of the job
#SBATCH -t 03:00:00

#SBATCH --mem=10G

# Keep this line if you need a GPU for your job
#SBATCH --partition=gpu

# Indicates that you need one GPU node
#SBATCH --gres=gpu:tesla:1


# script arguments
IMAGES_PATH=$1  # required
[ -z "$IMAGES_PATH" ] && exit 1

EXP_PATH=$2
[ -z "$EXP_PATH" ] && EXP_PATH="exp"
DET_EXP_NAME=$3
[ -z "$DET_EXP_NAME" ] && DET_EXP_NAME="exp"

IUO_TH=$4
[ -z "$IUO_TH" ] && IUO_TH=0.45
CONF_TH=$5
[ -z "$CONF_TH" ] && CONF_TH=0.25


# Load Python
module load any/python/3.8.3-conda

# Activate your environment
conda activate env_wsi

# MoNuSeg benchmarks:
#--iou-thres 0.3 and 0.6 \
#10%
#--conf-thres 0.00701 \
# 25%
#--conf-thres 0.01602
# 50%
#--conf-thres 0.03403
# 100%
#--conf-thres 0.09209
which python

python detect.py --img 1024 \
                 --nosave \
                 --agnostic-nms \
                 --line-thickness 1 \
                 --conf-thres $CONF_TH \
                 --iou-thres $IUO_TH \
                 --hide-labels --hide-conf \
                 --save-txt --save-conf \
                 --source "$IMAGES_PATH" \
                 --name "$EXP_PATH/wsi/$DET_EXP_NAME" \
                 --weights "$PROJECT_HISTOPATHOLOGY_DIR/yolov5/runs/train/$EXP_PATH/weights/best.pt"

echo "DONE"
