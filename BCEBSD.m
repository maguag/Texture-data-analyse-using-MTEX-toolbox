%% Start
clear;
% mapping EBSD  IPF, PF, ODF ... for silicon steel project
%% Crystal and Specimen Symmetries

CS = (crystalSymmetry('m-3m', [2.9 2.9 2.9], 'mineral', 'Iron bcc', 'color', [0.53 0.81 0.98]));
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');
pname = 'C:\Users\23727\Desktop\Mtex-EBSD\EBSD-Data';
fname = [pname '\TC-023-1-RD.cpr'];
%% Import the Data
ebsd = EBSD.load(fname,CS,'interface','crc',...
  'convertEuler2SpatialReferenceFrame');
% rotate the orientation data but not the spatial data



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
ipfKey = ipfColorKey(ebsd);
colors = ipfKey.orientation2color(ebsd('Iron bcc').orientations);
figure()
plot(ebsd('Iron bcc'),colors);
grains = calcGrains(ebsd('Iron bcc'),'angle',3*degree);
grains = smooth(grains,2);
% %grains boundary
hold on
plot(grains.boundary,'lineWidth',2);
hold off

%% Set Micronbar Fontsize and Length

f = gcm;
mp=getappdata(f.currentAxes,'mapPlot');
% mp=getappdata(gcm().currentAxes,'mapPlot');
mp.micronBar.txt.FontSize = 20; 
mp.micronBar.length = 100; 
mp.micronBar.backgroundColor = 'w';
mp.micronBar.lineColor = 'k';

%% PF Cubic(001)

% rot=rotation('Euler', 2*degree, 2*degree, 0*degree);
% ebsd=rotate(ebsd,rot,'keepXY'); 
% % RD = vector3d.X;
% % TD = vector3d.Y;
% % ND = vector3d.Z;
% 
% ori=ebsd('Iron bcc').orientations;
% x=Miller(0,0,1,ori.CS);          
% %x=[Miller(0,0,1,ori.CS), Miller(1,1,0,ori.CS), Miller(1,1,1,ori.CS)]; 
% figure();
% plotPDF(ori,x,'antipodal', 'contour', 1:1:10, 'minmax', 'colorRange',[0,10]);
% mtexColorbar ('location','southOutSide','title','mrd'); 


%% %grain size distribution 

% figure();
% histogram(grains.area);
% xlabel('grain area');
% ylabel('number of grains');

%% BC
% figure();
% plot(ebsd,ebsd.bc);
% colormap gray;
% mtexColorbar;

%% plot ipfkey

% ipfKey = ipfColorKey(ebsd);
% % ipfKey.inversePoleFigureDirection = vector3d.Z;
% figure();
% plot(ipfKey)

%% Plot ODF(0,45deg)

% psi = calcKernel(grains('Iron bcc').meanOrientation);
% HALF_WIDTH = psi;
% ori = ebsd('Iron bcc').orientations;
% ori.SS = specimenSymmetry('orthorhombic');
% odf = calcDensity(ori,'kernel',psi);
% figure();
% plot(odf,'phi2',45*degree,'antipodal','linewidth',1.5,'contour',1:1:10,'colorRange',[0,10]); 
% mtexColorbar

%% --ODF_all

% odf = calcDensity(ebsd('Iron bcc').orientations);
% plotSection(odf,'contour');
% mtexColorMap LaboTeX
% mtexColorbar

%%  KAM

% ebsd = ebsd.gridify;
% plot(ebsd,ebsd.KAM('threshold',2.5*degree) ./ degree,'micronbar','off')
% caxis([0,1])
% mtexColorbar
% mtexColorMap LaboTeX
% hold on
% plot(grains.boundary,'lineWidth',1.5)
% hold off

%% Backup
% %---------back up orientations-----
% %2------2-(100)<011>----------------
% hold on
% ori2 = orientation.byMiller([1 0 0],[0 1 1],ebsd('Iron bcc').CS);
% grains_selected2 = grains.findByOrientation(ori2,20*degree)
% plot(grains_selected2,'FaceColor','pink');
% hold off
% %4------4-(110)<001>------------------
% hold on
% ori4 = orientation.byMiller([1 1 0],[0 0 1],ebsd('Iron bcc').CS);
% grains_selected4 = grains.findByOrientation(ori4,15*degree)
% plot(grains_selected4,'FaceColor','green');
% hold off
% %---------5-(110)<1-12>--------
% hold on
% ori5 = orientation.byMiller([1 1 0],[1 -1 2],ebsd('Iron bcc').CS);
% grains_selected5 = grains.findByOrientation(ori5,15*degree)
% plot(grains_selected5,'FaceColor','BlueViolet');
% hold off
% %----------6-(110)<2-27>----------
% hold on
% ori6 = orientation.byMiller([1 1 0],[2 -2 7],ebsd('Iron bcc').CS);
% grains_selected6 = grains.findByOrientation(ori6,15*degree)
% plot(grains_selected6,'FaceColor','Brown');
% hold off
% %----------7-(111)<1-10>---------
% hold on
% ori7 = orientation.byMiller([1 1 1],[1 -1 0],ebsd('Iron bcc').CS);
% grains_selected7 = grains.findByOrientation(ori7,15*degree)
% plot(grains_selected7,'FaceColor','DodgerBlue');
% hold off
% %-------------9-(210)<001>---------
% hold on
% ori9 = orientation.byMiller([2 1 0],[0 0 1],ebsd('Iron bcc').CS);
% grains_selected9 = grains.findByOrientation(ori9,20*degree)
% plot(grains_selected9,'FaceColor','Cornsilk');
% hold off

%% 
% [grains,ebsd.grainId] = calcGrains(ebsd('indexed'),'threshold',[5*degree, 15*degree])
% gB = [grains.boundary grains.innerBoundary]
% figure;
% plotAngleDistribution(gB.misorientation)
%% end
