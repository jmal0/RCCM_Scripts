%% Test actuator repeatability

pix2um = 11.0; % Microns per pixel
dirname = uigetdir();

[repeat, dx, dy] = calculate_repeatability(pix2um, dirname);
disp(repeat);
save(['repeatability', datestr(now, 'dd-mm-yy'), '.mat'], 'dx', 'dy');
