import cv2
import utils
import numpy as np
import matplotlib.pyplot as plt
from skimage.util import img_as_ubyte
#k1: So ca the trong lan toi uu 1
#k2: So ca the trong lan toi uu 2
def imagefusion(i_pet, i_mri, k1 = 100, k2 = 100):
    i_pet, maxval = utils.im2double(i_pet)
    i_mri, _ = utils.im2double(i_mri)
    i_pet_ihs, v1, v2 = utils.rgb2ihs(i_pet)
    theta1, _fval1 = utils.PS_Optimize_DWT(i_mri, i_pet_ihs[:,:, 0], k1)
    # print('fval: {}'.format(fval1))
    i_pet_ihs[:, :, 0] = utils.enhance_DWT(i_mri, i_pet_ihs[:,:, 0], theta1)
    new_img1 = utils.ihs2rgb(i_pet_ihs, v1, v2)
    theta2, _fval2 = utils.PS_Optimize(i_pet_ihs[:, :, 0], k2, maxval)
    i_pet_ihs[:, :, 0] = utils.enhance(i_pet_ihs[:, :, 0], theta2, maxval)
    new_img2 = utils.ihs2rgb(i_pet_ihs, v1, v2)
    cv2.imshow('mri', i_mri)
    cv2.imshow('pet', i_pet)
    cv2.imshow('f1', new_img1)
    cv2.imshow('f2', new_img2)
    cv2.waitKey(0)
    cv2.imwrite('./pso_70_Minh.bmp', (new_img2)*maxval)
    
mri = cv2.imread('./SampleImages/070_mri.bmp', cv2.IMREAD_GRAYSCALE)
pet = cv2.imread('./SampleImages/070_pet.bmp')
# ipet, maxvalue = utils.im2double(pet)
# pet_ihs, v1, v2 = utils.rgb2ihs(ipet)
# temp = utils.ihs2rgb(pet_ihs, v1, v2)
# cv2.imshow('a', temp)
# cv2.waitKey(0)
# cv2.destroyAllWindows()

imagefusion(pet, mri)
# print(pet.shape)
# utils.cost_func_DWT(mri, pet, )