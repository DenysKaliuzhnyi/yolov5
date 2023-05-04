#!/bin/bash
# The name of the job is
#SBATCH -J train_monuseg

# Format of the output filename
#SBATCH -o slurm-out/slurm-%j.out

#SBATCH --cpus-per-task=8

# The maximum walltime of the job
#SBATCH -t 3-00:00:00

#SBATCH --mem=20G

# Keep this line if you need a GPU for your job
#SBATCH --partition=gpu

# Indicates that you need one GPU node
#SBATCH --gres=gpu:tesla:1


# script arguments
DATA_FILE_PATH=$1  # required
[ -z "$DATA_FILE_PATH" ] && exit 1
EXP_PATH=$2
[ -z "$EXP_PATH" ] && EXP_PATH="exp"

# Load Python
module load any/python/3.8.3-conda

# Activate your environment
source env/bin/activate

#wandb offline
#wandb online
#                --evolve 300 \
#                --hyp data/hyps/hyp.scratch-med.yaml \
#                --hyp runs/evolve/MoNuSeg_train2021_yolov5/exp_2022-04-19_17:31:27_train_hyp_med_default_full_evolve300_10_4/hyp_evolve.yaml \
#                --hyp runs/evolve/MoNuSeg_train2021_yolov5/exp_2022-04-22_00:04:12_evolve_gen100_epoch100/hyp_evolve.yaml \
#                --upload_data val \

#runs/train/instances_train2017_yolov5/exp_test_mine_obj_pw\=0_01_obj\=1_2022-07-13_03\:32\:48/weights/best.pt
#runs/train/MoNuSeg_train2021_yolov5/exp_2022-06-14_20:54:36_train_hyp_med_obj_pw=0_1_obj=1/weights/best.pt
#yolov5s.pt
python train.py --img 1024 \
                --batch 32 \
                --exist-ok \
                --epochs 300 \
                --patience 0 \
                --bbox_interval 10 \
                --weights yolov5s.pt \
                --hyp data/hyps/hyp.scratch-testis.yaml \
                --data "$DATA_FILE_PATH" --name "$EXP_PATH"

echo "DONE"

