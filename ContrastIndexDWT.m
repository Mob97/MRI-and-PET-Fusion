
% x la vector dau vao, x(1) la alpha, x(2) la beta
% alpha, beta thuoc [0,1]
% I_pet la kenh I anh pet dau vao dang so thuc
% I_mri la anh mri dau vao dang so thuc
function f = ContrastIndexDWT(x, I_pet, I_mri)

[LL_mri, LH_mri, HL_mri, HH_mri] = dwt2(I_mri,'haar');
[LL_pet, LH_pet, HL_pet, HH_pet] = dwt2(I_pet,'haar');

LL_new = (x(1)/(x(1)+x(2)))*LL_mri + (x(2)/(x(1)+x(2)))*LL_pet;

LH_new = max(LH_mri, LH_pet);
HL_new = max(HL_mri, HL_pet);
HH_new = max(HH_mri, HH_pet);

%Ham tang cuong tong hop tu 3 anh da tang cuong theo 3 cach khac nhau, su
%dung them cac he so alpha, beta, gama
I_en = idwt2(LL_new, LH_new, HL_new, HH_new, 'haar');

M = mean(I_en(:));    % Ham tinh gia tri trung binh cua anh, ma tran 2 chieu
V = var(I_en(:),1);   % Ham tinh phuong sai cua anh, ma tran 2 chieu
H1 = entropy(I_mri);      % Ham tinh gia tri entropy cua anh xam truoc khi tang cuong
H2 = entropy(I_en);   % Ham tinh gia tri entropy cua anh xam sau khi tang cuong

f = (V/M)*(H1-H2);    % Ham nang luong cua 3 bien alpha, beta
end
