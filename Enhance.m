% I la anh dau vao dang so thuc
% x la bo 3 so alpha, beta, gama toi uu tim duoc

function f = Enhance(I, x)

I_eq = histeq(I);     % Ham can bang Histogram
I_edge = edge(I,'Canny'); % Ham tim bien anh theo Candy
I_tv = medfilt2(I);       % Ham loc nhieu

%Ham tang cuong tong hop tu 3 anh da tang cuong theo 3 cach khac nhau, su
%dung them cac he so alpha, beta, gama
f = x(1)*I_eq + x(2)*I_edge + x(3)*I_tv;
end

