clear;
%%----ipfkey

cs = crystalSymmetry('m-3m');

ipfkey= ipfColorKey(cs);
h= Miller({0 0 1},{1 0 1},{1 1 1},cs);
f= sphericalRegion.byVertices(h);

plot(ipfkey,f)







