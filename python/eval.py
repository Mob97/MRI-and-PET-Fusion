import cv2
import utils
import numpy as np

img1 = cv2.imread('./pso_70.bmp')
img2 = cv2.imread('./pso_70_Minh.bmp')
# print(img1)
i1, _1 = utils.im2double(img1)
I1, _, _ = utils.rgb2ihs(i1)
m1, v1, e1, s1 = utils.danhGia(I1)
print('Mean: {}, Variance: {}, Entropy: {}, Sharpness: {}'.format(m1,v1,e1,s1))
i2, _2 = utils.im2double(img2)
I2, _, _ = utils.rgb2ihs(i2)
m2, v2, e2, s2 = utils.danhGia(I2)
print('Mean: {}, Variance: {}, Entropy: {}, Sharpness: {}'.format(m2,v2,e2,s2))