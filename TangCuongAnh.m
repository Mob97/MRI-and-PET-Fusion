% Thuc hien tang cuong Anh mau theo cac buoc trong bai bao
% Dau vao la anh I
% Dau ra la anh I da duoc tang cuong
% Thuc hien viec tang cuong anh, dong thoi lay cac chi so danh gia
% n la so ca the trong dan, n cang cao thi cang tot, nhung hieu nang se
% giam
%f la anh sau khi duoc tang cuong
% v1 la cac chi so danh gia truoc khi tang cuong
% v2 la cac chi so danh gia sau khi tang cuong
function [f1, f2, v1, v2, x1, x2] = TangCuongAnh(I_pet, I_mri, n1, n2)
% Buoc 1: Chuan hoa anh, chuyen anh ve mien [0, 1]
%I_pet = ChuanHoa(I_pet);
%I_mri = rgb2gray(ChuanHoa(I_mri));

I_pet = im2double(I_pet);
I_mri = im2double(rgb2gray(I_mri));

% Buoc 2: Tach ra 3 kenh mau PET va chuyen ve mien IHS

R = I_pet(:,:,1);
G = I_pet(:,:,2);
B = I_pet(:,:,3);

I = (R+G+B)/3;

V1 = (-sqrt(2)*R -sqrt(2)*G + 2*sqrt(2)*B)/6;
V2 = (R-G)/sqrt(2);

H = atan(V1./(V2+eps));
S = sqrt(V1.^2 + V2.^2);
% Buoc 3: Tong hop hinh anh

% Bien doi dwt cua 2 anh Imri va I
%[LLmri, LHmri, HLmri, HHmri] = dwt2(I_mri,'haar');
%[LL, LH, HL, HH] = dwt2(I,'haar');

% Tong hop
%LLth = (LLmri + LL)/2;

%LHth = max(LHmri, LH);
%HLth = max(HLmri, HL);
%HHth = max(HHmri, HH);

% Bien doi nguoc Haar

%Ith = idwt2(LLth, LH, HL, HH,'haar');
%I_th = idwt2(LLth, LHth, HLth, HHth,'haar');
%f1 = I_th;
x1 = ToiUuPSO_DWT(I_mri, I , n1);

I_th = Enhance_DWT(I_mri, I, x1);
%--------------------------------------------

R1 = I_th - V1/sqrt(2) + V2/sqrt(2);
G1 = I_th - V1/sqrt(2) - V2/sqrt(2);
B1 = I_th + sqrt(2)*V1;
f1 = im2uint8(cat(3,R1,G1,B1)); %im2uint8

%-------------------------------------------

% Thuc hien lay chi so danh gia cua anh truoc khi tang cuong
v1 = DanhGiaAnh(I_th);

%Buoc 3: Tach ra kenh I de tang cuong bang PSO
% Thu duoc cac gia tri alpha, beta, gama sau toi uu
x2 = ToiUuPSO(I_th, n2); 

% Goi ham tang cuong voi bo alpha, beta, gama toi uu tim duoc
I_en = Enhance(I_th,x2);

% Thuc hien lay chi so danh gia cua anh sau tang cuong
v2 = DanhGiaAnh(I_en);

% Buoc 4: Lay kenh I_en sau khi tang cuong cung voi cac kenh H, S de chuyen
% nguoc lai mien RGB

R2 = I_en - V1/sqrt(2) + V2/sqrt(2);
G2 = I_en - V1/sqrt(2) - V2/sqrt(2);
B2 = I_en + sqrt(2)*V1;

f2 = im2uint8(cat(3,R2,G2,B2)); %im2uint8

end

