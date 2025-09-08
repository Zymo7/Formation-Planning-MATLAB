function h=heuristic(id, start_all, ref_point, X,goal)
h1 = sqrt(sum((X-goal).^2));
% n = id;
% start = start_all;
% start_ctr(1) = sum(start(:,1))/4;
% start_ctr(2) = sum(start(:,2))/4;
% ref_point_advanced = start(n,:) - start_ctr(1,:) + ref_point;


% 改进A*
if norm(ref_point) ~= 0
    h2 = 1.5*sqrt(sum((X-ref_point).^2));
    h = h1 + h2;
else 
    h = h1;
end

% h = h1;
end