import numpy as np
import pywt
from pyswarm import pso
import skimage    
import cv2
import scipy.io
from scipy.stats import entropy
from skimage.util import img_as_ubyte
def im2double(im):
    info = np.iinfo(im.dtype) # Get the data type of the input image
    return im.astype(np.float)/info.max, info.max # Divide all values by the largest possible value in the datatype

def rgb2ihs(im, eps = 2.2204e-16):
    R = im[:,:,0]
    G = im[:,:,1]
    B = im[:,:,2]

    I = (R + G + B)/3.0
    v1 = (-np.sqrt(2)*R -np.sqrt(2)*G + 2*np.sqrt(2)*B)/6.0
    v2 = (R-G)/np.sqrt(2)
    H = np.arctan(v1/(v2+eps))
    S = np.sqrt(v1**2 + v2**2)
    IHS = np.zeros(im.shape)
    IHS[:,:,0] = I
    IHS[:,:,1] = H
    IHS[:,:,2] = S
    return IHS, v1, v2


def ihs2rgb(im, v1, v2):
    I = im[:,:,0]
    R = I - v1/np.sqrt(2) + v2/np.sqrt(2)
    G = I - v1/np.sqrt(2) - v2/np.sqrt(2)
    B = I + np.sqrt(2)*v1
    RGB = np.zeros(im.shape)
    RGB[:,:,0] = R
    RGB[:,:,1] = G
    RGB[:,:,2] = B
    return (RGB)

#theta: alpha, beta
def enhance_DWT(i_mri, i_pet, theta):    
    ll_m, (lh_m, hl_m, hh_m) = pywt.dwt2(i_mri, 'haar')
    ll_p, (lh_p, hl_p, hh_p) = pywt.dwt2(i_pet, 'haar')
    ll_fusion = theta*ll_m + (1-theta)*ll_p
    lh_fusion = np.maximum(lh_m, lh_p)
    hl_fusion = np.maximum(hl_m, hl_p)
    hh_fusion = np.maximum(hh_m, hh_p)
    new_image = pywt.idwt2((ll_fusion, (lh_fusion, hl_fusion, hh_fusion)), 'haar')
    # cv2.imwrite('./test.jpeg', new_image)
    # scipy.io.savemat('./arrdata.mat', mdict={'arr': new_image})
    # print(skimage.measure.shannon_entropy(new_image))
    return new_image


#theta: alpha, beta
def cost_func_DWT(i_mri, i_pet, theta):    
    ll_m, (lh_m, hl_m, hh_m) = pywt.dwt2(i_mri, 'haar')
    ll_p, (lh_p, hl_p, hh_p) = pywt.dwt2(i_pet, 'haar')
    # ll_fusion = (theta)*ll_m + (1-theta)*ll_p
    ll_fusion = theta*ll_m + (1-theta)*ll_p
    lh_fusion = np.maximum(lh_m, lh_p)
    hl_fusion = np.maximum(hl_m, hl_p)
    hh_fusion = np.maximum(hh_m, hh_p)
    new_image = pywt.idwt2((ll_fusion, (lh_fusion, hl_fusion, hh_fusion)), 'haar')
    mean = np.mean(new_image)
    var = np.var(new_image)
    entropy_before_enhance = skimage.measure.shannon_entropy(i_mri)
    entropy_after_enhance = skimage.measure.shannon_entropy((new_image*255).astype('uint8'))
    # entropy_after_enhance = skimage.measure.shannon_entropy(img_as_ubyte(new_image))
    # print(entropy_after_enhance)
    # print(entropy_before_enhance - entropy_after_enhance)
    cost = (var/mean)*(entropy_before_enhance - entropy_after_enhance)
    # print('Loss: {}'.format(cost))
    return cost

def PS_Optimize_DWT(i_mri, i_pet, k):
    func = lambda theta: cost_func_DWT(i_mri, i_pet, theta)
    # def myfunc(x):
    #     return cost_func_DWT(i_mri, i_pet, x)
    lb = [0.001]
    ub = [0.999]
    xopt, fopt = pso(func, lb, ub, swarmsize=k, maxiter=100, debug = True)
    return xopt, fopt

def cost_func(I, theta, maxval):
    temp = (I*maxval).astype('uint8')
    eqhist = cv2.equalizeHist(temp)
    edge = cv2.Canny(temp,100,200)
    filted = cv2.medianBlur(temp, 3)
    new_image = theta[0]*eqhist + theta[1]*edge + (1 - theta[0] - theta[1])*filted
    mean = np.mean(new_image)
    var = np.var(new_image)
    entropy_before_enhance = skimage.measure.shannon_entropy(I*maxval)
    entropy_after_enhance = skimage.measure.shannon_entropy(new_image)
    return (var/mean)*(entropy_before_enhance - entropy_after_enhance)

def enhance(I, theta, maxval):
    temp = (I*maxval).astype('uint8')
    eqhist = cv2.equalizeHist(temp)
    edge = cv2.Canny(temp,100,200)
    filted = cv2.medianBlur(temp, 3)
    new_image = theta[0]*eqhist + theta[1]*edge + (1 - theta[0] - theta[1])*filted
    new_image, _ = im2double(new_image.astype('uint8'))
    return new_image

def PS_Optimize(I, k, maxval):
    func = lambda theta: cost_func(I, theta, maxval)
    # def myfunc(x):
    #     return cost_func_DWT(i_mri, i_pet, x)
    lb = [0.001, 0.001]
    ub = [0.999, 0.999]
    xopt, fopt = pso(func, lb, ub, swarmsize=k, maxiter=100, debug = True)
    return xopt, fopt

# def spatialFrequency(I):
#     h, w = I.shape
#     sumRF = 0 # calculate Raw Frequency RF 
#     for i in range(h):
#         for j in range(w):
#             sumRF += I[h-1, w-1] 

def danhGia(I):
    mean = np.mean(I)
    var = np.var(I)
    en = skimage.measure.shannon_entropy(I)
    sharp = sharpness(I)
    return mean, var, en, sharp

def sharpness(I):
    Gx, Gy = intermediateDifference(I)
    S = np.sqrt(Gx**2 + Gy**2)
    return np.sum(S)/(np.size(Gx))

def intermediateDifference(I):
    Gx = np.zeros(I.shape, dtype=np.float32)
    Gy = np.zeros(I.shape, dtype=np.float32)
    Gx[:, :-1] = I[:, 1:] - I[:, :-1]
    Gy[:-1, :] = I[1:, :] - I[:-1, :]
    return Gx, Gy

