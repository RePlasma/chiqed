%% pair emission
% get efficiency of rejection method for different chi values
ndraws = 1e3;
effdim = 13;
effmc_smpl = zeros(effdim,1);
effmc_th = zeros(effdim,1);
chilst = logspace(-1,3,effdim);
for i=1:effdim
    chi = chilst(i);
    [th1_x,th1_y,smpl1_x,smpl1_y,effmc_smpl(i)] = photon_aux(chi,ndraws);
    % theory
    epsmaq = 1e-2;
    dim = 50;
    etalst1 = linspace(epsmaq,chi-epsmaq,dim);
    dP1 = arrayfun( @(eta) d2Pdeta(chi,eta), etalst1);
    nrm1 = trapz(etalst1/chi,dP1);
    effmc_th(i) = nrm1/max(dP1);
end
% plot
pltth=plot(chilst,effmc_th,'-b','LineWidth',2);
hold on
pltsmpl=plot(chilst,effmc_smpl,'.k','MarkerSize',15);
set(gca,'XScale','log')
xlim([min(chilst),max(chilst)])
ylim([0,1])

%% style
fnt = 24;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
pbaspect([1.62 1 1])
xlabel('$\chi$','FontSize', fnt, 'Interpreter','latex')
ylabel('efficiency','FontSize', fnt, 'Interpreter','latex')
legend([pltsmpl,pltth],{'MC','theory'},'FontSize',22, 'Interpreter','latex')
t=title('Pair emission - MC rejection','FontSize', fnt, 'Interpreter','latex');