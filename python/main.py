import pydicom as pyd
from pydicom.data import get_testdata_files
import matplotlib.pyplot as plt
import cv2
# ds = pyd.dcmread("ADNI_137_S_1041_MR_MP-RAGE__br_raw_20081218140326994_45_S61000_I131842.dcm")
# # ds = pydicom.dcmread(filename)  # plan dataset
# print(ds.pixel_array)
# plt.imshow(ds.pixel_array) 
# cv2.imshow('a', ds.pixel_array)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

img = cv2.imread('/home/minhbq-ars/Downloads/ChestX-ray14 Dataset/images/00000003_006.png', cv2.IMREAD_GRAYSCALE)
# print(img)
img, max_val = im2double(img)
