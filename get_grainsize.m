CS = (crystalSymmetry('m-3m', [2.9 2.9 2.9], 'mineral', 'Iron bcc', 'color', [0.53 0.81 0.98]));
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');
pname = 'C:\Users\23727\Desktop\Mtex-EBSD\EBSD-Data';
fname = [pname '\TC-023-1-RD.cpr'];
fname1 = [pname '\TC-027-2-RD.cpr'];
%% Import the Data
ebsd = EBSD.load(fname1,CS,'interface','crc',...
  'convertEuler2SpatialReferenceFrame');

%%
grains = calcGrains(ebsd('Iron bcc'),'angle',3*degree);
figure();
b = histogram(grains.area,15);
set(gca,"XLim",[-100,2000],"XTick",[0:500:2000])
xlabel('grain area');
ylabel('number of grains');
b.Values;