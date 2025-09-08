function feasible=feasiblePoint(point,map)
feasible=true;
% 检测point是否为障碍物或超出地图范围，若是障碍物或超出范围则返回false，否则返回true
if ~(point(1)>=1 && point(1)<=size(map,1) && point(2)>=1 && point(2)<=size(map,2) && map(point(1),point(2))==1)
    feasible=false;
end