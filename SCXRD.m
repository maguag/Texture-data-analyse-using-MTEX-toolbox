%% Import Script for PoleFigure Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = crystalSymmetry('m-3m', [2.9 2.9 2.9]);


% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = 'C:\Users\23727\Desktop\XRD织构数据';
fname = [pname '\SiFe-Texture-PSD.uxd'];

%% Specify Miller Indice

h = { ...
  Miller(1,1,0,CS),...
  Miller(2,2,0,CS),...
  Miller(3,1,1,CS),...
  };

%% Import the Data

% create a Pole Figure variable containing the data
pf = PoleFigure.load(fname,h,CS,'interface','uxd');
figure
plot(pf,'MarkerSize',2)
mtexColorbar

figure
plot(pf,'contourf')
mtexColorbar
mtexColorMap parula


odf = calcODF(pf,'silent')
plotPDF(odf,pf.h,'antipodal')
mtexColorMap parula
mtexColorbar
