length = zeros(num,1);
z = swarm_path;
for n = 1 : num
    for i = 1 : H-1
        length(n) = length(n) + norm(z{n}(i,:) - z{n}(i+1,:));
    end
end 
ave_length = sum(length)/num;


load ASCO_traj3.mat
ASCO_length = zeros(num,1);
z = traj;
for n = 1 : num
    for i = 1 : size(z{1},1)-1
        ASCO_length(n) = ASCO_length(n) + norm(z{n}(i,:) - z{n}(i+1,:));
    end
end 
ave_ASCO_length = sum(ASCO_length)/num;
