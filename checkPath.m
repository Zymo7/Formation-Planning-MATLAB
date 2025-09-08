function feasible=checkPath(n,newPos,map) 
feasible=true;
dir=atan2(newPos(1)-n(1),newPos(2)-n(2));
% 检测点n与点newPos之间的栅格点是否为障碍物，如果有障碍物则返回
for r=0:0.5:sqrt(sum((n-newPos).^2))
    posCheck=n+r.*[sin(dir) cos(dir)];
    if ~(feasiblePoint(ceil(posCheck),map) && feasiblePoint(floor(posCheck),map) && ... 
         feasiblePoint([ceil(posCheck(1)) floor(posCheck(2))],map) && ...
         feasiblePoint([floor(posCheck(1)) ceil(posCheck(2))],map))
        feasible=false;
        break;
    end

end
% 判断newPos是否为障碍物或超出地图范围
if ~feasiblePoint(newPos,map)
    feasible=false; 
end