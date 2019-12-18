clear all

Irmi = im2double(imread('070_mri.bmp'));
MRI = rgb2gray(Irmi);
 
RGB = im2double(imread('070_pet.bmp'));

R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

I = (R+G+B)/3;
DanhGiaAnh(I)
V1 = (-sqrt(2)*R -sqrt(2)*G + 2*sqrt(2)*B)/6;
V2 = (R-G)/sqrt(2);

H = atan(V1./(V2+eps));
S = sqrt(V1.^2 + V2.^2);

% Bien doi dwt cua 2 anh Imri va I
[LLmri, LHmri, HLmri, HHmri] = dwt2(MRI,'haar');
[LL, LH, HL, HH] = dwt2(I,'haar');

% Tong hop
LLth = (LLmri + LL)/2;

LHth = max(LHmri, LH);
HLth = max(HLmri, HL);
HHth = max(HHmri, HH);

% Bien doi nguoc Haar

%Ith = idwt2(LLth, LH, HL, HH,'haar');
Ith = idwt2(LLth, LHth, HLth, HHth,'haar');

%v1 = DanhGiaAnh(I_th);
% Thu duoc cac gia tri alpha, beta, gama sau toi uu
x = ToiUuPSO(I, 100); %n 

% Goi ham tang cuong voi bo alpha, beta, gama toi uu tim duoc
I_en = Enhance(Ith,x); 

% Thuc hien lay chi so danh gia cua anh sau tang cuong
v2 = DanhGiaAnh(I_en);

% Buoc 4: Lay kenh I_en sau khi tang cuong cung voi cac kenh H, S de chuyen
% nguoc lai mien RGB
%HSI = cat(3, H, S, I_en);
%f = im2uint8(hsi2rgb(HSI));


%----------------------------------------------------
R1 = I_en - V1/sqrt(2) + V2/sqrt(2);
G1 = I_en - V1/sqrt(2) - V2/sqrt(2);
B1 = I_en + sqrt(2)*V1;

I1 = cat(3,R1,G1,B1);

imshow([RGB,Irmi, I1],[])

