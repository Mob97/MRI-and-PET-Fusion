% I la anh dau vao dang so thuc
% x la bo 3 so alpha, beta, gama toi uu tim duoc

function f = Enhance_DWT(I_mri, I_pet, x)

[LL_mri, LH_mri, HL_mri, HH_mri] = dwt2(I_mri,'haar');
[LL_pet, LH_pet, HL_pet, HH_pet] = dwt2(I_pet,'haar');

LL_new = (x(1)/(x(1)+x(2)))*LL_mri + (x(2)/(x(1)+x(2)))*LL_pet;

LH_new = max(LH_mri, LH_pet);
HL_new = max(HL_mri, HL_pet);
HH_new = max(HH_mri, HH_pet);

%Ham tang cuong tong hop tu 3 anh da tang cuong theo 3 cach khac nhau, su
%dung them cac he so alpha, beta, gama
f = idwt2(LL_new, LH_new, HL_new, HH_new, 'haar');

end

