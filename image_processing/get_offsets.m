function [dx, dy] = get_offsets(dirname)
%GET_OFFSETS  Compute pixel shift from a teach image for image sequence
% Inputs
%   dirname  Directory containing all images with first one being taught
% Outputs
%   dx  Column vector containg column shifts from reference image
%   dy  Column vector containg row shifts from reference image

% Teach 1st image in directory
files = dir([dirname, '\*.bmp']);
[search_zone, teach_zone, teach_fft] = teach_img([dirname, '\', files(1).name]);

% Create arrays for storing offsets
dx = zeros(numel(files), 1);
dy = zeros(numel(files), 1);

h = figure('visible', 'off');
for i = 2:numel(files)
    % Get offset of this image from teach
    [dxi, dyi] = get_offset([dirname, '\', files(i).name], search_zone, teach_fft, h);
    
    % Show where teach image was found
    rect_new = teach_zone - [dxi, dyi, 0, 0];
    rectangle('Position', rect_new);
    
    print(sprintf('%d', i), '-dpng');
    
    % Save offsets
    dy(i) = dyi;
    dx(i) = dxi;
end
