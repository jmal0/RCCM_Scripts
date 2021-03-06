function [search_zone, teach_zone, teach_fft] = teach_img(filename, bwflag)
%TEACH_IMG  Create teach image from user selection within given image
% Inputs
%   filename  Full path of image to be taught
%   bwflag    Optional. Flag indicating if black background should be used
%            (default is white).

if nargin == 1
    bwflag = 0;
end

% Load image
img = im2double(imread(filename));
if (size(img, 3) > 1)
    img = rgb2gray(img);
end

% Have user select region in which to look for teach image
disp('Select search zone');
figure;
[~, search_zone] = imcrop(img);
search_zone = [floor(search_zone(1:2)), ceil(search_zone(3:4))];
search_img = imcrop(img, search_zone);

% Have user select region within image to search for
disp('Select teach zone');
[~, teach_zone] = imcrop(search_img);
teach_zone = [floor(teach_zone(1:2)), ceil(teach_zone(3:4))];
crop_img = imcrop(search_img, teach_zone);

% Create adjusted reference image with background whited out
if ~bwflag
    % Use white background
    teach_img = ones(size(search_img));
else
    % Use black background
    teach_img = zeros(size(search_img));
end

% Place taught section of image on blank background
teach_img(teach_zone(2):(teach_zone(2) + teach_zone(4)), ...
          teach_zone(1):(teach_zone(1) + teach_zone(3))) ...
          = crop_img;

% Calculte fft and save for repeated use during shifted image analysis
teach_fft = fft2(teach_img);

% Show taught image (background removed)
figure;
imshow(teach_img)