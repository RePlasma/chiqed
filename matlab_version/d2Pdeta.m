%chitil - chi tilde
%chip - chi plus
%chim - chi minus

function res = d2Pdeta(chi,eta)

chip = eta/chi;
chim = 1 - chip;
chitil = 2/(3*chi*chip*chim);
res = 1/chi * ( (chip/chim + chim/chip)*besselk(2/3,chitil)+integral(@(x) besselk(1/3,x),chitil,Inf) );