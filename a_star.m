function path = a_star(id, flag, center_path, start, goal, mapOriginal,mapResized,map,conn,display_process,resolutionX,resolutionY, start_all)
%% Compute path

% 节点的结构是1.x位置、2.y位置、3.历史成本、4.启发式成本、5.总成本、6.封闭列表中的父索引
open=[start 0 heuristic(id, start_all, [0,0],start,goal) 0+heuristic(id, start_all, [0,0],start,goal) -1]; % A*算法的open列表，首先将start加入其中
closed=ones(size(map));
closedList=[];
pathFound=false;
tic; % 开始计时
counter=0;

% size(open)
while size(open,1) > 0
     [~, I] = min(open,[],1); % A为open列表的每一行的最小值组成的行向量，I为A中元素在open中对应的行数
     n = open(I(5),:);        % 最小总代价f对应的open列表中的行，代表当前要处理的节点n
     if flag
         dist = zeros(size(center_path,1),1);
         for i = 1 : size(center_path)
            dist(i) = norm(n(1:2) - center_path(i,1:2));
         end
         [~, row] = min(dist,[],1);
     end
     
     open = [open(1:I(5)-1,:);open(I(5)+1:end,:)]; % 从opne列表中删除正在处理中的节点n
     if n(1)==goal(1) && n(2)==goal(2) %如果当前检测节点是目标点，则退出循环，搜索结束
         pathFound = true;
         break;
     end
     % 开始对当前处理节点周围的子节点进行计算，选择f值最小的作为下一个处理节点
     [rx,ry,rv] = find(conn==2); % 连接矩阵中的机器人位置，rx和ry分别存储邻接矩阵中每个2的行列，rv存储数量
     [mx,my,mv] = find(conn==1); % 可能移动的数组，mx和my分别存储邻接矩阵中每个1的行列，mv存储数量
     % 遍历所有的子节点
     for mxi = 1:size(mx,1)      
         newPos = [n(1)+mx(mxi)-rx n(2)+my(mxi)-ry];
         if checkPath(n(1:2),newPos,map) 
              if closed(newPos(1),newPos(2))~=0 
              % 如果从n到newPos的路径是无碰撞且不超出地图范围的 且 不在closed列表中
                  historicCost = n(3)+historic(n(1:2),newPos); % 更新历史代价g
                  if flag
                      heuristicCost = heuristic(id, start_all, center_path(row,1:2),newPos,goal); % 更新启发代价h
                  else 
                      heuristicCost = heuristic(id, start_all, [0,0],newPos,goal);
                  end
                  totalCost = historicCost+heuristicCost; % 更新总代价f
                  add = true; % add表示是否将当前扩展节点加入open列表
                  % 检查open中是否存在当前扩展的子节点newPos
                  if length(find((open(:,1)==newPos(1)) .* (open(:,2)==newPos(2))))>=1
                      % I代表已经存在open中的节点所在的行
                      I = find((open(:,1)==newPos(1)) .* (open(:,2)==newPos(2)));

                      if open(I,3) < historicCost % 若已经存在的节点有更小的代价，则不加入当前节点
                          add=false;
                      else                     
                          open = [open(1:I-1,:);open(I+1:end,:);];
                          add=true;
                      end
                  end
                  % 如果当前子节点不在open中，或在open中但是其代价较小，则将其加入open中，其父节点是当前处理点
                  if add
                      open = [open;newPos historicCost heuristicCost totalCost size(closedList,1)+1]; %在队列中添加新节点
                  end
              end
         end           
     end
     closed(n(1),n(2))=0; % 将当前处理过的节点n坐标存储到closed
     closedList=[closedList;n]; % 将当前处理过的节点n的信息存储到closelist列表
     i0 = counter;
     i1 = 50;
     counter=counter+1;
     % 画出动态搜索过程
     if display_process == true && (rem(i0,i1) == 0) 
         temp_img = (map==0).*0 + ((closed==0).*(map==1)).*125 + ((closed==1).*(map==1)).*255 + (mapResized - map).*100 ;
         
         %画出目标和起始点
         temp_img(goal(1), goal(2) ) = 160;
         temp_img(start(1), start(2) ) = 160;
        
         image(temp_img);
       
         M(counter)=getframe;
     end     
%      size(open)
end

if ~pathFound
    error('no path found')
end
%% Plot complete path绘制完整路线
% figure
path=[n(1:2)]; % 从源信息检索路径，当前n为终点
prev=n(6);     % 当前点的父节点对应的closed索引
while prev>0
    path=[closedList(prev,1:2);path];
    prev=closedList(prev,6);
end
path_original = [(path(:,1)*size(mapOriginal,1))/resolutionX (path(:,2)*size(mapOriginal,2))/resolutionY];
pathLength=0;
for i=1:length(path_original)-1
    pathLength=pathLength+historic(path_original(i,:),path_original(i+1,:)); 
end
% fprintf('processing time=%d \nPath Length=%d \n\n', toc,pathLength);
% 
% imshow(mapOriginal);
% line(path_original(:,2),path_original(:,1));

save open open
save closed closed;
save n n;
save closedList closedList;
save path path;

