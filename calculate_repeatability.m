function [repeat, dx, dy] = calculate_repeatability(pix2um, dirname)
%CALCULATE_REPEATABILITY

addpath('./image_processing/');

% Get pixel shifts and compute best fit
[dx, dy] = get_offsets(dirname);
dx = dx*pix2um;
dy = dy*pix2um;

repeat = sqrt(std(dx)^2 + std(dy)^2);

% Plot results
figure;
hold on;
plot(dx, dy, 'b.')
xlabel('X offset (micron)')
ylabel('Y offset (micron)')
