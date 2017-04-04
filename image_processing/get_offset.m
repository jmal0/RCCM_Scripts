function [dx, dy] = get_offset(filepath, search_zone, teach_fft, h)
%GET_OFFSET  Calculate pixel shift of image from taught parameters
% Inputs
%   filepath     Complete filename of image
%   search_zone  4 element array representing crop region in which to
%                search for teach image
%   teach_fft    fft of teach image
% Outputs
%   dx  Column (x) shift from teach image in pixels
%   dy  Row (y) shift from teach image in pixels

usfac = 100; % Upsample factor (# of pixel divisions to use)

% Read new image and save as array of grayscale values on [0, 1]
img = im2double(imread(filepath));
if (size(img, 3) > 1)
    img = rgb2gray(img);
end
img_crop = imcrop(img, search_zone);

figure(h);
clf;
hold on
imshow(img_crop, 'border', 'tight');

% Calculate offset by subpixel registration algorithm
[output, ~] = dftregistration(teach_fft, fft2(img_crop), usfac);

dy = output(3);
dx = output(4);