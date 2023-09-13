function [th1_x,th1_y,smpl1_x,smpl1_y,effmc1] = photon_aux(eta1,ndraws)
epsmaq = 1e-2;
dim = 50;
% theory
etalst1 = linspace(epsmaq,eta1-epsmaq,dim);
dP1 = arrayfun( @(chi) d2Pdchi(eta1,chi), etalst1);
nrm1 = trapz(etalst1/eta1,dP1);
% sampling
nbins = 20;
counts = 0; % total number of draws
fun = @(chi) d2Pdchi(eta1,chi); % function to sample from
multc = 1.1*max(dP1); % the c in c q(x)
xmin = epsmaq; xmax = eta1-epsmaq; % define interval to sample from
xlst = zeros(ndraws,1); % array of samples
% sample
i=1;
while i <= ndraws
    y = (xmax-xmin)*rand+xmin; % take Y from uniform distribution [xmin,xmax]
    u = rand; % take U from uniform distribution [0,1]
    if multc*u <= fun(y) % accept value only if U < c Y
        xlst(i) = y;
        i = i + 1;
    end
    counts = counts+1;
end
% "efficiency of the draws"
effmc1=ndraws/counts;
% histogram
edges = linspace(0,eta1,nbins);
[histN,histedges] = histcounts(xlst,edges);
[xlst_smpl,dNdx_smpl] = histline(histedges, histN);
% assign to variables
th1_x = etalst1/eta1;
th1_y = dP1/nrm1;
smpl1_x = xlst_smpl/eta1;
smpl1_y = dNdx_smpl/sum(dNdx_smpl)*nbins;