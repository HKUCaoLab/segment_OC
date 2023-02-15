import pyreadr
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


# set threshold and corresbonding frequency with ICC>threshold
def nfeats_ICC(ICCs, thres_min, thres_max, thres_diff):
    thres = np.arange(thres_min, thres_max+thres_diff, step=thres_diff)
    freqs = []
    for ii in thres:
        fq = sum(ICCs>ii)
        freqs.append(fq)
    d = {'R1': thres, 'R2': np.array(freqs)}
    df = pd.DataFrame(data=d)
    return df


def load_df(df_path):
    df = pyreadr.read_r(df_path)
    return df[None]


def draw_fig1(df_plot0, df_plot1, df_plot2):
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax1.plot('R1', 'R2', data=df_plot0, c='r', linestyle='-', marker="o")
    # ax1.plot('R1', 'R2', data=df_plot1, c='b', linestyle='-', marker="o", label='ICC<=0.9')
    # ax1.plot('R1', 'R2', data=df_plot2, c='g', linestyle='-', marker="o", label='ICC<=0.8')
    plt.xlim(0.2, 1.0)
    # add horizontal lines
    for ii in np.arange(10, 110, 10):
        plt.axhline(ii, lw=0.6, ls='--', c='black')
    plt.xlabel('ICC Threshold', fontsize=12)
    plt.ylabel('Percentage of features (%)', fontsize=12)
    # plt.legend(title="Included features with")
    plt.show()


def draw_fig2(df_fig, label_color, label_txt, hl_max, hl_min=0.0):
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    ax1.plot('R1', 'R2', data=df_fig, c=label_color, linestyle='-', marker="o", label=label_txt)
    # add horizontal lines
    for ii in np.arange(hl_min, hl_max+0.1, 0.1):
        plt.axhline(ii, lw=0.6, ls='--', c='black')
    plt.xlabel('Number of Features', fontsize=12)
    plt.ylabel('ICC', fontsize=12)
    plt.legend(title="Included features with", loc='lower left')
    plt.show()


# Plot Figure 7
# Legend: Stability analysis of radiomics features
def draw_fig3(df_perc, df_freq, save_fname):
    fig, ax1 = plt.subplots(figsize=(8, 5))

    ax1.set_xlim(0.2, 1.0)
    ax1.set_ylim(0, 100)
    ax1.plot('R1', 'R2', data=df_perc, c='r', linestyle='-', marker="o")
    ax1.set_xlabel('ICC Threshold', fontsize=12)
    ax1.set_ylabel('Percentage of features (%)', fontsize=12)
    # add horizontal lines
    for ii in np.arange(10, 110, 10):
        ax1.axhline(ii, lw=0.6, ls='--', c='black')

    # Instantiate a second axes that shares the same x-axis
    ax2 = ax1.twinx()
    ax2.set_ylim(0, 1217)
    ax2.plot('R1', 'R2', data=df_freq, c='r', linestyle='-', marker="o")
    ax2.set_ylabel('Number of Features', fontsize=12)

    # set the spacing
    plt.subplots_adjust(left=0.1, right=0.9, wspace=0.2)
    plt.show()
    if save_fname is not None:
        fig.savefig(save_fname, dpi=300)
    return plt, ax1, ax2


if __name__ == '__main__':
    df_path = r'D:\DL_CaOvary'

    df_p0 = load_df(df_path + '\\df_plot0.rds')
    # df_p1 = load_df(df_path + '\\df_plot1.rds')
    # df_p2 = load_df(df_path + '\\df_plot2.rds')
    # draw_fig1(df_p0, df_p1, df_p2)

    df_ICC0 = load_df(df_path + '\\df_ICC0.rds')
    df_f2 = nfeats_ICC(df_ICC0[None], 0.0, 1.0, 0.02)
    # df_ICC1 = load_df(df_path + '\\df_ICC1.rds')
    # df_f3 = nfeats_ICC(df_ICC1[None], 0.0, 0.9, 0.02)
    # df_ICC2 = load_df(df_path + '\\df_ICC2.rds')
    # df_f4 = nfeats_ICC(df_ICC2[None], 0.0, 0.8, 0.02)
    # draw_fig2(df_f2, 'r', 'ICC<=1.0', 1.0)
    # draw_fig2(df_f3, 'b', 'ICC<=0.9', 0.9)
    # draw_fig2(df_f4, 'g', 'ICC<=0.8', 0.8)
    plt, ax1, ax2 = draw_fig3(df_p0, df_f2, "Fig5.tiff")
    print("------")
