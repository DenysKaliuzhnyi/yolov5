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
EXP_PATH=$2
[ -z "$EXP_PATH" ] && EXP_PATH="exp"
TASK=$3
[ -z "$TASK" ] && TASK="val"
VAL_EXP_NAME=$4
[ -z "$VAL_EXP_NAME" ] && VAL_EXP_NAME="exp"
IUO_TH=$5
[ -z "$IUO_TH" ] && IUO_TH=0.45



# Load Python
module load any/python/3.8.3-conda

# Activate your environment
source env/bin/activate

# --iou-thres
# ann 10%: iou 20%
python val.py --img 1024 --batch-size 64 --workers 4 \
              --task "$TASK" \
              --single-cls \
              --iou-thres "$IUO_TH" \
              --exist-ok \
              --data "$DATA_FILE_PATH" --name "$EXP_PATH/$TASK/$VAL_EXP_NAME" \
              --weights "$PROJECT_HISTOPATHOLOGY_DIR/yolov5/runs/train/$EXP_PATH/weights/best.pt"

echo "DONE"
