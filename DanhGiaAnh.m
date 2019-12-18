% Ham nay thu hien danh gia 4 thong so cua Anh
% Trung binh, phuong sai, entropy, gradient 
function f = DanhGiaAnh(I)

%I = rgb2gray(I);
f(1) = mean(I(:));
f(2) = var(I(:),1);
f(3) = entropy(I);
f(4) = sharpness(I);
f(5) = SpatialFrequency(I);

end

function f = sharpness(I)

[Gx, Gy] = imgradientxy(I,'intermediate');

S=sqrt(Gx.*Gx+Gy.*Gy);
f = sum(sum(S))./(numel(Gx));

end

function f = SpatialFrequency(I)
% M=number of rows; N=number of columns in the image
%I = rgb2gray(I);
%I = im2double(I);
M = size(I,1); 
N = size(I,2);
% calculate Raw Frequency RF 
SumRF = 0;

for i=1:M 
    for j=2:N
      SumRF = SumRF + (I(M,N)-I(M,N-1)^2);  
    end
end
RF = sqrt(SumRF/(M*N)); 
    
% calculate Column Frequency CF 
SumCF = 0;

for i=1:N 
    for j=2:M
      SumCF = SumCF + (I(M,N)-I(M-1,N)^2);  
    end
end
CF = sqrt(SumCF/(M*N));  
% calculate Spatial Frequency SF output
f = sqrt(RF^2+CF^2);
end


