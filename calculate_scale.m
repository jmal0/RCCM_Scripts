function pix2um = calculate_scale(positions, dirname)
%CALCULATE_SCALE  Compute microns per pixel from sequence of shifted images
% Inputs
%   positions  Array containing position coordinate (in microns) where each
%              image was taken (assumed to be in same order as file order)
%   dirname    Directory containing sequence of images (assumed to be .bmp)
% Outputs
%   pix2um  Microns/pixels calculated from best fit of pixel positions vs
%           given image location in microns

addpath('./image_processing/');

% Get pixel shifts and compute best fit
[dx, dy] = get_offsets(dirname);
pos_pix = sqrt(dx.^2 + dy.^2);
p = polyfit(pos_pix, positions, 1);

% Micron/pixel scaling is slope of best fit line
pix2um = p(1);

% Plot results
figure;
hold on;
plot(pos_pix, positions, 'bo')
xline = [pos_pix(1), pos_pix(end)];
plot(xline, p(1)*xline + p(2), '--k')
xlabel('Shift in pixels')
ylabel('Actual shift in mm')
legend('Images', 'Best fit line')
