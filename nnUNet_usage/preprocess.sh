#!/usr/bin/env bash

source ~/.bashrc

# set paths for nnUNet, no need to modify $HOME/.bashrc
export nnUNet_raw_data_base="/scratch/yiang/nnUNet/nnUNet_raw"
export nnUNet_preprocessed="/scratch/yiang/nnUNet/nnUNet_preprocessed"
export RESULTS_FOLDER="/scratch/yiang/nnUNet/nnUNet_trained_models"

nnUNet_plan_and_preprocess -t 102 --verify_dataset_integrity


