%% Get microns/pixel scaling

[datafile, datapath] = uigetfile('*.mat');
load([datapath, datafile]);
dirname = uigetdir();

pix2um = calculate_scale(1000*positions, dirname);
save(['pix2um', datestr(now, 'dd-mm-yy'), '.mat'], 'pix2um');