%Ham chuan hoa anh, chuyen anh tu [0 255] ve mien [0 1]
% R = [0 10 0; 20 250 85; 30 15 45];
% G = [255 40 9; 55 125 10; 5 7 23];
% B = [50 51 53; 50 52 55; 51 54 53];
% I = cat(3,R,G,B);
function f = ChuanHoa(I)

% Tach ra 3 kenh mau
R = I(:,:,1); 
G = I(:,:,2);
B = I(:,:,3);

R_min = min(R(:)); %Lay ra tri min cua ma tran R
R_max = max(R(:)); %Lay ra tri max cua ma tran R
R_ch = double(R-R_min)/double(R_max-R_min); 

% Doi voi kenh G
G_min = min(min(G));
G_max = max(max(G));
G_ch = double(G-G_min)/double(G_max-G_min);

% Doi voi kenh B
B_min = min(min(B));
B_max = max(max(B));
B_ch = double(B-B_min)/double(B_max-B_min);

f = cat(3, R_ch, G_ch, B_ch);
end

