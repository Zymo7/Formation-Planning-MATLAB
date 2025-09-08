function new_path = segmentation(path,t,h,M,H)

% 加密原路径点
new_path = [];
for i = 1:M-1
    new_segment_x = linspace(path(i, 1), path(i+1, 1), h+1);
    new_segment_y = linspace(path(i, 2), path(i+1, 2), h+1);
    new_path = [new_path; [new_segment_x(1:end-1)', new_segment_y(1:end-1)']];
end
new_path = [new_path; path(end, :)];
for i = 1:H-1
    direction(i) = wrapToPi(atan2( (new_path(i+1,1) - new_path(i,1)) ,(new_path(i+1,2) - new_path(i,2)) ))/t;
end
direction(H) = direction(H-1);
new_path = [new_path, direction'];