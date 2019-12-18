function IHS = rgb2ihs(Irgb)
R = Irgb(:,:,1);
G = Irgb(:,:,2);
B = Irgb(:,:,3);

I = (R+G+B)/3;

V1 = (-sqrt(2)*R -sqrt(2)*G + 2*sqrt(2)*B)/6;
V2 = (R-G)/sqrt(2);

H = atan(V1./(V2+eps));
S = sqrt(V1.^2 + V2.^2);
IHS = cat(3,I,H,S);
end

