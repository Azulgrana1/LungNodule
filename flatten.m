function [ output2d ] = flatten( input3d )
%flatten
% input 3d block, convert to 2d image
output2d = zeros(200, 320);
h = 40;w = 320;
flatten = input3d(:,:);
for i = 1:5
    output2d(h*(i-1)+1:h*i, :) = flatten(:, w*(i-1)+1:w*i);
end
min_im = min(output2d(:));
max_im = max(output2d(:));
output2d = (output2d - min_im)/max_im;
end

