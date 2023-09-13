%% photon emission
% get efficiency of rejection method for different eta values
ndraws = 1e3;
effdim = 13;
effmc_smpl = zeros(effdim,1);
effmc_th = zeros(effdim,1);
etalst = logspace(-1,3,effdim);
for i=1:effdim
    eta = etalst(i);
    [th1_x,th1_y,smpl1_x,smpl1_y,effmc_smpl(i)] = photon_aux(eta,ndraws);
    % theory
    epsmaq = 1e-2;
    dim = 50;
    chilst1 = linspace(epsmaq,eta-epsmaq,dim);
    dP1 = arrayfun( @(chi) d2Pdchi(eta,chi), chilst1);
    nrm1 = trapz(chilst1/eta,dP1);
    effmc_th(i) = nrm1/max(dP1);
end
% plot
pltth=plot(etalst,effmc_th,'-b','LineWidth',2);
hold on
pltsmpl=plot(etalst,effmc_smpl,'.k','MarkerSize',15);
set(gca,'XScale','log')
xlim([min(etalst),max(etalst)])
ylim([0,1])

%% style
fnt = 24;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
pbaspect([1.62 1 1])
xlabel('$\eta$','FontSize', fnt, 'Interpreter','latex')
ylabel('efficiency','FontSize', fnt, 'Interpreter','latex')
legend([pltsmpl,pltth],{'MC','theory'},'FontSize',22, 'Interpreter','latex')
t=title('Photon emission - MC rejection','FontSize', fnt, 'Interpreter','latex');