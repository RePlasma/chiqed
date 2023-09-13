%% photon emission
% compare histograms with theoretical distributions
% aux
%     get peak of distribution and adapt multiplicative factor accordingly
%     this method only allows for efficiency of ~50%
ndraws = 1e4;
[th1_x,th1_y,smpl1_x,smpl1_y,effmc1] = photon_aux(1,ndraws);
[th10_x,th10_y,smpl10_x,smpl10_y,effmc10] = photon_aux(10,ndraws);
[th100_x,th100_y,smpl100_x,smpl100_y,effmc100] = photon_aux(100,ndraws);

% plot
plt1=plot(th1_x,th1_y,'-b','LineWidth',2);
hold on
plot(smpl1_x,smpl1_y,'.b','MarkerSize',15)
hold on
plt10=plot(th10_x,th10_y,'-r','LineWidth',2);
hold on
plot(smpl10_x,smpl10_y,'.r','MarkerSize',15)
hold on
plt100=plot(th100_x,th100_y,'-g','LineWidth',2);
hold on
plot(smpl100_x,smpl100_y,'.g','MarkerSize',15)
%{
subplot(1,2,2)
plot(th1_x,th1_y,'-b')
hold on
plot(smpl1_x,smpl1_y,'.b')
hold on
plot(th10_x,th10_y,'-r')
hold on
plot(smpl10_x,smpl10_y,'.r')
hold on
plot(th100_x,th100_y,'-g')
hold on
plot(smpl100_x,smpl100_y,'.g')
hold on
set(gca,'XScale','log')
xlim([1e-2,1])
%}

%% style
fnt = 24;
ax = gca;
ax.Box = 'on';
ax.BoxStyle = 'full';
ax.FontSize = fnt;
ax.TickLabelInterpreter = 'latex';
pbaspect([1.62 1 1])
xlabel('$\chi/\eta$','FontSize', fnt, 'Interpreter','latex')
ylabel('$dP/d\chi$','FontSize', fnt, 'Interpreter','latex')
t=title('Photon emission','FontSize', fnt, 'Interpreter','latex');
%t.Units = 'Normalize'; 
%t.Position(1) = 0;
%t.HorizontalAlignment = 'left';
legend([plt1,plt10,plt100],{'$\eta=1$','$\eta=10$','$\eta=100$'},'FontSize',22, 'Interpreter','latex')