#!/usr/bin/env bash

# set paths for nnUNet, no need to modify $HOME/.bashrc
export nnUNet_raw_data_base="/scratch/yiang/nnUNet/nnUNet_raw"
export nnUNet_preprocessed="/scratch/yiang/nnUNet/nnUNet_preprocessed"
export RESULTS_FOLDER="/scratch/yiang/nnUNet/nnUNet_trained_models"


source ~/.bashrc

# find best configuration
nnUNet_find_best_configuration -m 2d 3d_fullres 3d_lowres 3d_cascade_fullres -t 102 --strict >best_config.log


