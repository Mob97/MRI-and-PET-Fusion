% ts la vector cho tham so dau ra
% x la vector dau vao, x(1) la alpha, x(2) la beta, x(3) la gama
% alpha thuoc [0,1], beta thuoc [0,4), gamma thuoc [1,5)
% I la anh dau vao dang so thuc
function f = ContrastIndex(x, I)

I_eq = histeq(I);     % Ham can bang Histogram
I_edge = edge(I,'Canny'); % Ham tim bien anh theo Candy
I_tv = medfilt2(I);       % Ham loc nhieu

%Ham tang cuong tong hop tu 3 anh da tang cuong theo 3 cach khac nhau, su
%dung them cac he so alpha, beta, gama
I_en = x(1)*I_eq + x(2)*I_edge + x(3)*I_tv;

M = mean(I_en(:));    % Ham tinh gia tri trung binh cua anh, ma tran 2 chieu
V = var(I_en(:),1);   % Ham tinh phuong sai cua anh, ma tran 2 chieu
H1 = entropy(I);      % Ham tinh gia tri entropy cua anh xam truoc khi tang cuong
H2 = entropy(I_en);   % Ham tinh gia tri entropy cua anh xam sau khi tang cuong

f = (V/M)*(H1-H2);    % Ham nang luong cua 3 bien alpha, beta, gamma 
end
