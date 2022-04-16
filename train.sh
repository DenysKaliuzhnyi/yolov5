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
SEED=$3  # not required
IMG_PCNT=$4  # not required
ANN_PCNT=$5  # not required


# Load Python
module load any/python/3.8.3-conda

# Activate your environment
source env/bin/activate

python train.py --img 512 --batch 64 --workers 4 \
                --epochs 300 \
                --hyp hyp_med.yaml --weights yolov5s.pt \
                --optimizer AdamW --image-weights \
                --bbox_interval 10 \
                --data "$DATA_FILE_PATH" --name "$EXP_PATH" \
    	 	        --seed "$SEED" --images-percent "$IMG_PCNT" --annotations-percent "$ANN_PCNT"
# --upload_dataset have a bug - don't work

echo "DONE"


#python train.py 
#	--img-size 512 
#	--batch-size 32 
#	--epochs 300 
#	--data data/monuseg.yaml 
#	--weights '' 
#	--cfg yolov5s.yaml
#	--hyp data/hyps/hyp.scratch-low.yaml
#	--optimizer SGD
#	--workers 8
#	--name exp
#	--patience 100

