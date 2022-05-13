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

# Run `wandb sweep --project YOLOv5 utils/loggers/wandb/sweep.yaml` to create a sweep and fetch its id
# PS: configure sweep.yaml properly to your needs (at least specify correct data file path)
SWEEP_ID="5grn31dl"

# Load Python
module load any/python/3.8.3-conda

# Activate your environment
source env/bin/activate

# start agent
wandb agent --project YOLOv5 --entity kaliuzhnyi --count 110 "$SWEEP_ID"

echo "DONE"
