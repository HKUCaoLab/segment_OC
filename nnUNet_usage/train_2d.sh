#!/usr/bin/env bash

source ~/.bashrc

# set paths for nnUNet, no need to modify $HOME/.bashrc
export nnUNet_raw_data_base="/scratch/yiang/nnUNet/nnUNet_raw"
export nnUNet_preprocessed="/scratch/yiang/nnUNet/nnUNet_preprocessed"
export RESULTS_FOLDER="/scratch/yiang/nnUNet/nnUNet_trained_models"

CUDA_VISIBLE_DEVICES=2 nnUNet_train 2d nnUNetTrainerV2 102 0 -p nnUNetPlansv2.1_bs32 --npz 
CUDA_VISIBLE_DEVICES=2 nnUNet_train 2d nnUNetTrainerV2 102 1 -p nnUNetPlansv2.1_bs32 --npz 
CUDA_VISIBLE_DEVICES=2 nnUNet_train 2d nnUNetTrainerV2 102 2 -p nnUNetPlansv2.1_bs32 --npz 
CUDA_VISIBLE_DEVICES=2 nnUNet_train 2d nnUNetTrainerV2 102 3 -p nnUNetPlansv2.1_bs32 --npz 
CUDA_VISIBLE_DEVICES=2 nnUNet_train 2d nnUNetTrainerV2 102 4 -p nnUNetPlansv2.1_bs32 --npz 

exit
