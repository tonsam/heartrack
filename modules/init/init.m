global window Fs step Sig Hr  Tig order K Center visible;
Tig = importdata('allTestData.mat');
x = importdata('alldata.mat');
Sig = x.Sig;
Hr = x.Hr;
accData = importdata('accDataAll.mat');
window = 1000;
Fs = 125;
step = 250;
K = 2;
order = 10;
Center = accData.C{3};
visible = true; %% show graph or not
saveImgTo = '/home/xyzhang/Documents/WorkSpace/newIEEE/doc/figs/';