#!/usr/bin/env bash

source ~/.bashrc

# set paths for nnUNet, no need to modify $HOME/.bashrc
export nnUNet_raw_data_base="/scratch/yiang/nnUNet/nnUNet_raw"
export nnUNet_preprocessed="/scratch/yiang/nnUNet/nnUNet_preprocessed"
export RESULTS_FOLDER="/scratch/yiang/nnUNet/nnUNet_trained_models"

 
CUDA_VISIBLE_DEVICES=0 nnUNet_train 3d_cascade_fullres nnUNetTrainerV2CascadeFullRes 102 0 -p nnUNetPlansv2.1_bs4 --npz 
CUDA_VISIBLE_DEVICES=0 nnUNet_train 3d_cascade_fullres nnUNetTrainerV2CascadeFullRes 102 1 -p nnUNetPlansv2.1_bs4 --npz 
CUDA_VISIBLE_DEVICES=0 nnUNet_train 3d_cascade_fullres nnUNetTrainerV2CascadeFullRes 102 2 -p nnUNetPlansv2.1_bs4 --npz 
CUDA_VISIBLE_DEVICES=0 nnUNet_train 3d_cascade_fullres nnUNetTrainerV2CascadeFullRes 102 3 -p nnUNetPlansv2.1_bs4 --npz 
CUDA_VISIBLE_DEVICES=0 nnUNet_train 3d_cascade_fullres nnUNetTrainerV2CascadeFullRes 102 4 -p nnUNetPlansv2.1_bs4 --npz 


exit 

# if test -s cascade.log; then
# 	exit 1
# fi


