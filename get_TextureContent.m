clear;

CS = (crystalSymmetry('m-3m', [2.9 2.9 2.9], 'mineral', 'Iron bcc', 'color', [0.53 0.81 0.98]));
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');
pname = 'C:\Users\23727\Desktop\Mtex-EBSD\EBSD-Data';
fname = [pname '\TC-023-1-RD.cpr'];
%% Import the Data
ebsd = EBSD.load(fname,CS,'interface','crc',...
  'convertEuler2SpatialReferenceFrame');
%% EBSD data Denoising Methood

% %-----The Kuwahara Filter-----
K = KuwaharaFilter;
K.numNeighbours = 5;
% %-----The Median Filter----
F = medianFilter;
F.numNeighbours = 3;
% %-----The Mean Filter-----
M = meanFilter;
M.numNeighbours = 1;
% %-----The Halfquadratic Filter-----
H = halfQuadraticFilter;
% %-----The Smoothing Spline Filter-----
S = splineFilter;
%% %denosing EBSD Data 

% [grains,ebsd('Iron bcc').grainId] = calcGrains(ebsd('Iron bcc'));
% ebsd(grains(grains.grainSize<=5)) = [];
% [grains,ebsd('Iron bcc').grainId] = calcGrains(ebsd('Iron bcc'));
% ebsd = smooth(ebsd('Iron bcc'),K,'fill',grains);
% ebsd = smooth(ebsd('Iron bcc'),H,'fill',grains);
% [grains,ebsd('Iron bcc').grainId] = calcGrains(ebsd('Iron bcc'));
% nextAxis

%% Plot IPF with boundary

% ipfKey = ipfColorKey(ebsd);
% colors = ipfKey.orientation2color(ebsd('Iron bcc').orientations);
% figure();
% plot(ebsd('Iron bcc'),colors);
% grains = calcGrains(ebsd('Iron bcc'),'angle',3*degree);
% grains = smooth(grains,2);
% % %grains boundary
% hold on
% plot(grains.boundary,'lineWidth',2);
% hold off

%% Plot ODF(0,45deg)

% psi = calcKernel(grains('Iron bcc').meanOrientation);
% HALF_WIDTH = psi;
% ori = ebsd('Iron bcc').orientations;
% ori.SS = specimenSymmetry('orthorhombic');
% odf = calcDensity(ori,'kernel',psi);
% figure();
% plot(odf,'phi2',45*degree,'antipodal','linewidth',1.5,'contour',1:1:10,'colorRange',[0,10]); 
% mtexColorbar

%% % plot grains by millerorientation 

[grains,ebsd('Iron bcc').grainId] = calcGrains(ebsd('Iron bcc'),'angle',3*degree);
s=sum(grains.grainSize);
figure();
plot(grains.boundary,'lineWidth',2,'micronbar','on');

% %---------1-(110)<001> Goss for red---------
hold on
ori1 = orientation.byMiller([1 1 0],[0 0 1],ebsd('Iron bcc').CS);
grains_selected1 = grains.findByOrientation(ori1,15*degree);
plot(grains_selected1,'FaceColor','red');
hold off
s1 = sum(grains_selected1.grainSize);
% %---------8-(111)<11-2> green------------
hold on
ori8 = orientation.byMiller([1 1 1],[1 1 -2],ebsd('Iron bcc').CS);
grains_selected8 = grains.findByOrientation(ori8,15*degree);
plot(grains_selected8,'FaceColor','Green');
hold off
s8 = sum(grains_selected8.grainSize);
% %--------10-(411)<14-8> Lime-----------
hold on
ori10 = orientation.byMiller([4 1 1],[1 4 -8],ebsd('Iron bcc').CS);
grains_selected10 = grains.findByOrientation(ori10,15*degree);
plot(grains_selected10,'FaceColor','Lime');
hold off
s10 = sum(grains_selected10.grainSize);
% %-------3-(100)<021> bad for yellow------
hold on
ori3 = orientation.byMiller([1 0 0],[0 2 1],ebsd('Iron bcc').CS);
grains_selected3 = grains.findByOrientation(ori3,15*degree);
plot(grains_selected3,'FaceColor','yellow');
hold off
s3 = sum(grains_selected3.grainSize);
% %-------- replot boundary--------------
hold on
grains = calcGrains(ebsd('Iron bcc'),'angle',3*degree);
grains = smooth(grains,2);
plot(grains.boundary,'lineWidth',2);
hold off

f = gcm;
mp=getappdata(f.currentAxes,'mapPlot');
% mp=getappdata(gcm().currentAxes,'mapPlot');
mp.micronBar.txt.FontSize = 20; 
mp.micronBar.length = 100; 
mp.micronBar.backgroundColor = 'k';
mp.micronBar.lineColor = 'w';


%% calculate grainsize area boundarysize perimiter

sum(grains.grainSize) % ?????????-??????
sum(grains.area) %?????????-um2
sum(grains.perimeter)/(grains.size(1)*pi) %???????????????????????????????????m
2 * (sum(grains.area)/(grains.size(1)*pi))^(1/2) %??????-????????????

% sum(grains.perimeter) % ???????????m
% sum(grains.perimeter)/grains.size(1) %????????????
% sum(grains.area)/grains.size(1)%????????????
% sum(grains.diameter)/grains.size(1) %????????????????????m
% sum(2*grains.equivalentRadius)/grains.size(1)  %????????????-
% sum(grains.equivalentPerimeter)/grains.size(1)
