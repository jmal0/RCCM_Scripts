function [pix2um, dx, dy] = calculate_scale(positions, dirname)
%CALCULATE_SCALE  Compute microns per pixel from sequence of shifted images
% Inputs
%   positions  Array containing position coordinate (in microns) where each
%              image was taken (assumed to be in same order as file order)
%   dirname    Directory containing sequence of images (assumed to be .bmp)
% Outputs
%   pix2um  Microns/pixels calculated from best fit of pixel positions vs
%           given image location in microns
%   dx      Column (x) shifts from teach image in pixels
%   dy      Row (y) shifts from teach image in pixels

addpath('./image_processing/');

% Get pixel shifts and compute best fit
[dx, dy] = get_offsets(dirname);
pos_pix = sign(dx).*sqrt(dx.^2 + dy.^2);
p = polyfit(pos_pix, positions, 1);

% Micron/pixel scaling is slope of best fit line
pix2um = p(1);

% Plot results
figure;
hold on;
set(gca, 'FontSize', 16)
plot(pos_pix, positions/1000, 'bo', 'MarkerSize', 10)
xline = [min(pos_pix), max(pos_pix)];
plot(xline, (p(1)*xline + p(2))/1000, '--k', 'LineWidth', 2)
xlabel('Shift in pixels')
ylabel('Actual shift in mm')
legend('Images', 'Best fit line')
