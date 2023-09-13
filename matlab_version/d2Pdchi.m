%chitil - chi tilde
%chip - chi plus
%chim - chi minus

function res = d2Pdchi(eta,chi)

csi = chi/eta;
chitil = 2*csi/(3*eta*(1-csi));
res = chi * ( (1-csi+1/(1-csi))*besselk(2/3,chitil)-integral(@(x) besselk(1/3,x),chitil,Inf) );