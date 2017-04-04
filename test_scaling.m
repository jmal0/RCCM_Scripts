%% Get microns/pixel scaling

positions = 1000*[2:-1:-4, 3:1:7]';
dirname = uigetdir();

[pix2um, dx, dy] = calculate_scale(positions, dirname);
save(['pix2um', datestr(now, 'dd-mm-yy'), '.mat'], 'pix2um', 'dx', 'dy');