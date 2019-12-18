function RGB = ihs2rgb(IHS)

V1 = (-sqrt(2)*R -sqrt(2)*G + 2*sqrt(2)*B)/6;
V2 = (R-G)/sqrt(2);

R1 = I - V1/sqrt(2) + V2/sqrt(2);
G1 = I - V1/sqrt(2) - V2/sqrt(2);
B1 = I + sqrt(2)*V1;

I1 = cat(3,R1,G1,B1);


end

