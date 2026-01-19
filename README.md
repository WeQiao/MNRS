# MNRS：multi-factor network-based ranking score for revealing critical states of complex diseases based on gut microbiome data
## Overview

The progression of many diseases is not always gradual but sometimes occurs abruptly, with a critical threshold separating before-deterioration and after-deterioration states. Detecting such pre-disease states is crucial, as they often signal catastrophic changes. Evidence indicates that the development and progression of many diseases such as type 1 diabetes, celiac disease, and colorectal cancer are closely related to the gut microbiome. In this project, we propose a novel computational method called multi-factor network-based ranking score (MNRS) to detect pre-disease states from gut microbiome data. The proposed MNRS can infer perturbed microbial networks and quantifies dynamic changes at the species/genus level, thereby capturing signals of critical transitions. 
<img width="4724" height="4526" alt="MNRS Fig1" src="https://github.com/user-attachments/assets/72a051f0-c141-473e-8fb3-4be499906959" />

## Usage
Download the source codes and upzip the data.zip.
## Examples
This project takes an individual E003989 in the type 1 diabetes (T1D) dataset as an example to illustrate the specific application of the MNRS method. The input data can be changed with the other datasets if necessary.

Calculating multi-factor difference network input data: E003989_data.txt (contained in the data.zip)

### Step1. Calculate multi-factor difference network
Convert the original microbial abundance matrix data into a txt file. The rows represent species and the columns represent samples. As a single-sample method, the experimental group data can be obtained by adding one column of samples to be tested on the basis 

Input data: E003989_data.txt (contained in the data.zip)

Output data: changedata.mb

Running pipeline: networkbuild.R, which has been tested in R 4.2.1.

### Step2. Calculate multi-factor network-based ranking score (MNRS)
Input data: changedata.mb and E003989_data.txt (contained in the data.zip)

Output data: Dmean.txt

Running pipeline: networkbuild.R, which has been tested in in R 4.2.1.

Displaying result running pipeline: MNRS_curve.m, which has been tested in Matlab R2021a.
## Citation
Qiao Wei, Jiayuan Zhong, et al. MNRS：multi-factor network-based ranking score for revealing critical states of complex diseases based on gut microbiome data
## Contact
Qiao Wei: scut_wq@163.com

Jiayuan Zhong: Zjiayuan@foshan.edu.cn
