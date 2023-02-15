# Calculate the difference between two labels/ROIs
# Suppose the input image include labels/ROIs only contain two categories:
# 0: background; 1: labels/ROIs
import numpy as np


'''
# Calculate Dice score
# mask1 and mask2 are np arrays with same shape 
'''
def dice_score(mask1, mask2, smooth=1e-6):
    # Matrix dtype: int to float
    mask1 = mask1.astype(np.float32)
    mask2 = mask2.astype(np.float32)
    intersection = np.sum(mask1 * mask2)
    return (2. * intersection + smooth) / (np.sum(mask1) + np.sum(mask2) + smooth)


'''
# Calculate Confusion Matrix
# Input:
# mask1: reference/true mask;
# mask2: predicted mask;
# Output:
# number of TP/TN/FP/FN pixels: 
# np.array([[TP, FN], 
#           [FP, TN]])
'''
def confusion_matrix(mask1, mask2):
    tp = mask1 * mask2
    tn = (1 - mask1) * (1 - mask2)
    fp = (1 - mask1) * mask2
    fn = mask1 * (1 - mask2)
    return np.array([[np.sum(tp), np.sum(fn)], [np.sum(fp), np.sum(tn)]])


'''
# Calculate Cohen's Kappa score
# Input:
# confusion_mat: confusion matrix, number of cases (int), or probabilities (float) 
'''
def kappa(confusion_mat):
    confusion_mat = confusion_mat.astype(np.float32)
    pe_rows = np.sum(confusion_mat, axis=0)
    pe_cols = np.sum(confusion_mat, axis=1)
    sum_total = np.sum(pe_cols)
    pe = np.dot(pe_rows, pe_cols) / sum_total ** 2
    po = np.trace(confusion_mat) / sum_total
    return (po - pe) / (1 - pe)


# Test code
if __name__ == "__main__":
    import nibabel as nib
    import os

    def get_labels(label_fname):
        data = nib.load(label_fname)
        img = data.get_fdata()
        return img

    label1 = get_labels("D:\\001\\ROI_dwi.nii.gz")
    label2 = get_labels("D:\\001\\dwi.label.nii.gz")

    dice = dice_score(label1, label2)
    conf_mat = confusion_matrix(label1, label2)
    kappa_score = kappa(conf_mat)
    print("dice=", str(dice), ", kappa=", str(kappa_score))

