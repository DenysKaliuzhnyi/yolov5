#!/bin/bash
#SBATCH -J fiftyone
#SBATCH --partition=main
#SBATCH -t 1-00:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB

module load python/3.8.6
source env_fiftyone/bin/activate
python launch_fiftyone.py
echo "DONE"
