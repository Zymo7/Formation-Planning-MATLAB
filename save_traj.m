traj = zeros(size(swarm_path{1},1),8);
% traj(:,1) = swarm_path{1}(:,1);
% traj(:,2) = swarm_path{1}(:,2);
% traj(:,3) = swarm_path{1}(:,3);
% 
% traj(:,4) = swarm_path{2}(:,1);
% traj(:,5) = swarm_path{2}(:,2);
% traj(:,6) = swarm_path{2}(:,3);
% 
% traj(:,7) = swarm_path{3}(:,1);
% traj(:,8) = swarm_path{3}(:,2);
% traj(:,9) = swarm_path{3}(:,3);
% 
% traj(:,10) = swarm_path{4}(:,1);
% traj(:,11) = swarm_path{4}(:,2);
% traj(:,12) = swarm_path{4}(:,3);

traj(:,1) = swarm_path{1}(:,1);
traj(:,2) = swarm_path{1}(:,2);

traj(:,3) = swarm_path{2}(:,1);
traj(:,4) = swarm_path{2}(:,2);

traj(:,5) = swarm_path{3}(:,1);
traj(:,6) = swarm_path{3}(:,2);

traj(:,7) = swarm_path{4}(:,1);
traj(:,8) = swarm_path{4}(:,2);

save traj traj
load traj traj