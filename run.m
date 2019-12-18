clear all

I_mri = imread('060_mri.bmp');
I_pet = imread('060_pet.bmp');

%I_mri = imread('070_mri.bmp');
%I_pet = imread('070_pet.bmp');

%I_mri = imread('080_mri.bmp');
%I_pet = imread('080_pet.bmp');

%I_mri = imread('090_mri.bmp');
%I_pet = imread('090_pet.bmp');

%I_mri = imread('100_mri.bmp');
%I_pet = imread('100_pet.bmp');

%I_mri = imread('110_mri.bmp');
%I_pet = imread('110_pet.bmp');

%[f1, f2, v1, v2, x] = TangCuongAnh(I_pet, I_mri, 100,100);
[f1, f2, v1, v2, x1, x2] = TangCuongAnh(I_pet, I_mri, 100, 100);
imshow([I_pet, I_mri, f1, f2])
imwrite(f1,'dwt_60.bmp')
imwrite(f2,'pso_60.bmp')