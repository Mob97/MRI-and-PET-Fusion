% function to calculate Spatial Frequency. Calculations are from
% Li, S., Kwok, J. T., & Wang, Y. (2001). Combination of images with diverse focuses using the spatial frequency. Information fusion, 
% Eskicioglu, A. M., & Fisher, P. S. (1995). Image quality measures and their performance. IEEE
% contact: alp.durmus@sydney.edu.au 
function f = SF(I)
% M=number of rows; N=number of columns in the image
I = rgb2gray(I);
I = im2double(I);
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


