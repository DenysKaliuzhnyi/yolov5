#!/bin/bash
# The name of the job is
#SBATCH -J train_monuseg

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
DATA_FILE_PATH=$1  # required
[ -z "$DATA_FILE_PATH" ] && exit 1
IMAGES_PATH=$2  # required
[ -z "$IMAGES_PATH" ] && exit 1
EXP_PATH=$3
[ -z "$EXP_PATH" ] && EXP_PATH="exp"
IOU=$4
CONF=$5


# Load Python
module load any/python/3.8.3-conda

# Activate your environment
source env/bin/activate

python detect.py --img 512 \
                 --line-thickness 1 \
                 --hide-labels --hide-conf \
                 --save-txt --save-conf \
                 --data "$DATA_FILE_PATH" --name "$EXP_PATH" --source "$IMAGES_PATH" \
                 --weights "$PROJECT_HISTOPATHOLOGY_DIR/yolov5/runs/train/$EXP_PATH/weights/best.pt" \
                 --conf-thres "$CONF" --iou-thres "$IOU"
echo "DONE"
