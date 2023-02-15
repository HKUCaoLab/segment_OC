#!/usr/bin/env bash

# set paths for nnUNet, no need to modify $HOME/.bashrc
export nnUNet_raw_data_base="/scratch/yiang/nnUNet/nnUNet_raw"
export nnUNet_preprocessed="/scratch/yiang/nnUNet/nnUNet_preprocessed"
export RESULTS_FOLDER="/scratch/yiang/nnUNet/nnUNet_trained_models"

source ~/.bashrc


# create variables to represent folders
FOLDER_TEST="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/imagesTs"
OUTPUT_2d="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/op_2d"
OUTPUT_3d_lowres="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/op_3d_lowres"
OUTPUT_3d_fullres="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/op_3d_fullres"
OUTPUT_3d_cascade="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/op_3d_cascade"
OUTPUT_ensemble="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/ensemble"


# run inference for QMH, copy from best_config.log
nnUNet_predict -i $FOLDER_TEST -o $OUTPUT_2d -m 2d -p nnUNetPlansv2.1 -t 102 --save_npz
nnUNet_predict -i $FOLDER_TEST -o $OUTPUT_3d_lowres -m 3d_lowres -p nnUNetPlansv2.1 -t 102 --save_npz
nnUNet_predict -i $FOLDER_TEST -o $OUTPUT_3d_fullres -m 3d_fullres -p nnUNetPlansv2.1 -t 102 --save_npz
nnUNet_predict -i $FOLDER_TEST -o $OUTPUT_3d_cascade -m 3d_cascade_fullres -p nnUNetPlansv2.1 -t 102 --save_npz
# nnUNet_ensemble -f $OUTPUT_3d_lowres $OUTPUT_3d_cascade -o $OUTPUT_ensemble -pp /scratch/yiang/nnUNet/nnUNet_trained_models/nnUNet/ensembles/Task102_CaOvarySeg/ensemble_3d_lowres__nnUNetTrainerV2__nnUNetPlansv2.1--3d_cascade_fullres__nnUNetTrainerV2CascadeFullRes__nnUNetPlansv2.1/postprocessing.json


# calculate evaluation metrics for the prediction results
FOLDER_ref="/scratch/yiang/nnUNet/nnUNet_pred/Task102_CaOvarySeg_HK/labelsTs"
nnUNet_evaluate_folder -ref $FOLDER_ref -pred $OUTPUT_2d -l 1
nnUNet_evaluate_folder -ref $FOLDER_ref -pred $OUTPUT_3d_lowres -l 1
nnUNet_evaluate_folder -ref $FOLDER_ref -pred $OUTPUT_3d_fullres -l 1 
nnUNet_evaluate_folder -ref $FOLDER_ref -pred $OUTPUT_3d_cascade -l 1
# nnUNet_evaluate_folder -ref $FOLDER_ref -pred $OUTPUT_ensemble -l 1

