%% slide 20
% pair creation

epsmaq = 1e-3;
dim = 200;

chi1=1;
etalst1 = linspace(epsmaq,chi1-epsmaq,dim);
dP1 = arrayfun( @(eta) d2P(chi1,eta), etalst1);
P1 = zeros(numel(etalst1),1);
for i=2:numel(etalst1)
    P1(i) = trapz(etalst1(1:i)/chi1,dP1(1:i));
end
nrm1 = P1(end);

chi10=10;
etalst10 = linspace(epsmaq,chi10-epsmaq,dim);
dP10 = arrayfun( @(eta) d2P(chi10,eta), etalst10);
P10 = zeros(numel(etalst10),1);
for i=2:numel(etalst10)
    P10(i) = trapz(etalst10(1:i)/chi10,dP10(1:i));
end
nrm10 = P10(end);

chi100=100;
etalst100 = linspace(epsmaq,chi100-epsmaq,dim);
dP100 = arrayfun( @(eta) d2P(chi100,eta), etalst100);
P100 = zeros(numel(etalst100),1);
for i=2:numel(etalst100)
    P100(i) = trapz(etalst100(1:i)/chi100,dP100(1:i));
end
nrm100 = P100(end);

%% plot
subplot(1,2,1)
plot(etalst1/chi1,dP1/nrm1)
hold on
plot(etalst10/chi10,dP10/nrm10)
hold on
plot(etalst100/chi100,dP100/nrm100)
hold on

subplot(1,2,2)
plot(etalst1/chi1,P1/nrm1)
hold on
plot(etalst10/chi10,P10/nrm10)
hold on
plot(etalst100/chi100,P100/nrm100)
hold on