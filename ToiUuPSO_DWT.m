%Thuc hien toi uu de tim bo tham so cho 1 anh dau vao
% n la so luong ca the trong dan, n cang lon thi cang chinh xac, nhung thoi
% gian rat cham
function [ x, fval] = ToiUuPSO_DWT(I_mri, I_pet , n)
%Thiet lap cac tham so can thiet
muctieu = @(x)ContrastIndexDWT(x, I_pet, I_mri); % Mot ham tuu uu dinh nghia truoc, tham so truyen vao the nao khi chay
k = 2; % So luong bien can toi uu: alpha (0,1), beta (0,1), 
lb = [0.001; 0.001]; % Can duoi doi voi 3 bien alpha, beta
ub = [0.999; 0.999]; % Can tren doi voi 3 bien alpha, beta
options = optimoptions('particleswarm','SwarmSize',n); % So luong ca the trong dan la 20
%[x, fval] = particleswarm(muctieu,n); % Goi phuong thuc PSO de toi uu, tim ra duoc bien x de ham dat cu tieu
[x, fval] = particleswarm(muctieu,k,lb,ub,options);

end

