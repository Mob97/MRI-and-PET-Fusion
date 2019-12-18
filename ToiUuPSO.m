%Thuc hien toi uu de tim bo tham so cho 1 anh dau vao
% n la so luong ca the trong dan, n cang lon thi cang chinh xac, nhung thoi
% gian rat cham
function [ x, fval] = ToiUuPSO( I , n)
%Thiet lap cac tham so can thiet
muctieu = @(x)ContrastIndex(x,I); % Mot ham tuu uu dinh nghia truoc, tham so truyen vao the nao khi chay
k = 3; % So luong bien can toi uu: alpha (0,1), beta (0,4), gamma(1,5) 
lb = [0.001; 0.001; 0.001]; % Can duoi doi voi 3 bien alpha, beta, gamma
ub = [0.999; 0.999; 0.999]; % Can tren doi voi 3 bien alpha, beta, gamma
options = optimoptions('particleswarm','SwarmSize',n); % So luong ca the trong dan la 20
%[x, fval] = particleswarm(muctieu,n); % Goi phuong thuc PSO de toi uu, tim ra duoc bien x de ham dat cu tieu
[x, fval] = particleswarm(muctieu,k,lb,ub,options);

end

