clear all
% Doc anh xam MRI 
Imri = imread('070_mri.bmp');
Imri = im2double(rgb2gray(Imri));
% Doc anh mau pet dau vao (anh R G B)

I = imread('070_pet.bmp');
I = im2double(I);

IHS = rgb2ihs(I);

I = IHS(:,:,1);
H = IHS(:,:,1);
S = IHS(:,:,1);

% Bien doi dwt cua 2 anh Imri va I
[LLmri, LHmri, HLmri, HHmri] = dwt2(Imri,'haar');
[LL, LH, HL, HH] = dwt2(I,'haar');

% Tong hop
LLth = (LLmri + LL)/2;


imshow([LLmri,LL])