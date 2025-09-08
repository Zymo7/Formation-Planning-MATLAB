function path = a_star(id, flag, center_path, start, goal, mapOriginal,mapResized,map,conn,display_process,resolutionX,resolutionY, start_all)
%% Compute path

% �ڵ�Ľṹ��1.xλ�á�2.yλ�á�3.��ʷ�ɱ���4.����ʽ�ɱ���5.�ܳɱ���6.����б��еĸ�����
open=[start 0 heuristic(id, start_all, [0,0],start,goal) 0+heuristic(id, start_all, [0,0],start,goal) -1]; % A*�㷨��open�б����Ƚ�start��������
closed=ones(size(map));
closedList=[];
pathFound=false;
tic; % ��ʼ��ʱ
counter=0;

% size(open)
while size(open,1) > 0
     [~, I] = min(open,[],1); % AΪopen�б��ÿһ�е���Сֵ��ɵ���������IΪA��Ԫ����open�ж�Ӧ������
     n = open(I(5),:);        % ��С�ܴ���f��Ӧ��open�б��е��У�����ǰҪ����Ľڵ�n
     if flag
         dist = zeros(size(center_path,1),1);
         for i = 1 : size(center_path)
            dist(i) = norm(n(1:2) - center_path(i,1:2));
         end
         [~, row] = min(dist,[],1);
     end
     
     open = [open(1:I(5)-1,:);open(I(5)+1:end,:)]; % ��opne�б���ɾ�����ڴ����еĽڵ�n
     if n(1)==goal(1) && n(2)==goal(2) %�����ǰ���ڵ���Ŀ��㣬���˳�ѭ������������
         pathFound = true;
         break;
     end
     % ��ʼ�Ե�ǰ����ڵ���Χ���ӽڵ���м��㣬ѡ��fֵ��С����Ϊ��һ������ڵ�
     [rx,ry,rv] = find(conn==2); % ���Ӿ����еĻ�����λ�ã�rx��ry�ֱ�洢�ڽӾ�����ÿ��2�����У�rv�洢����
     [mx,my,mv] = find(conn==1); % �����ƶ������飬mx��my�ֱ�洢�ڽӾ�����ÿ��1�����У�mv�洢����
     % �������е��ӽڵ�
     for mxi = 1:size(mx,1)      
         newPos = [n(1)+mx(mxi)-rx n(2)+my(mxi)-ry];
         if checkPath(n(1:2),newPos,map) 
              if closed(newPos(1),newPos(2))~=0 
              % �����n��newPos��·��������ײ�Ҳ�������ͼ��Χ�� �� ����closed�б���
                  historicCost = n(3)+historic(n(1:2),newPos); % ������ʷ����g
                  if flag
                      heuristicCost = heuristic(id, start_all, center_path(row,1:2),newPos,goal); % ������������h
                  else 
                      heuristicCost = heuristic(id, start_all, [0,0],newPos,goal);
                  end
                  totalCost = historicCost+heuristicCost; % �����ܴ���f
                  add = true; % add��ʾ�Ƿ񽫵�ǰ��չ�ڵ����open�б�
                  % ���open���Ƿ���ڵ�ǰ��չ���ӽڵ�newPos
                  if length(find((open(:,1)==newPos(1)) .* (open(:,2)==newPos(2))))>=1
                      % I�����Ѿ�����open�еĽڵ����ڵ���
                      I = find((open(:,1)==newPos(1)) .* (open(:,2)==newPos(2)));

                      if open(I,3) < historicCost % ���Ѿ����ڵĽڵ��и�С�Ĵ��ۣ��򲻼��뵱ǰ�ڵ�
                          add=false;
                      else                     
                          open = [open(1:I-1,:);open(I+1:end,:);];
                          add=true;
                      end
                  end
                  % �����ǰ�ӽڵ㲻��open�У�����open�е�������۽�С���������open�У��丸�ڵ��ǵ�ǰ�����
                  if add
                      open = [open;newPos historicCost heuristicCost totalCost size(closedList,1)+1]; %�ڶ���������½ڵ�
                  end
              end
         end           
     end
     closed(n(1),n(2))=0; % ����ǰ������Ľڵ�n����洢��closed
     closedList=[closedList;n]; % ����ǰ������Ľڵ�n����Ϣ�洢��closelist�б�
     i0 = counter;
     i1 = 50;
     counter=counter+1;
     % ������̬��������
     if display_process == true && (rem(i0,i1) == 0) 
         temp_img = (map==0).*0 + ((closed==0).*(map==1)).*125 + ((closed==1).*(map==1)).*255 + (mapResized - map).*100 ;
         
         %����Ŀ�����ʼ��
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
%% Plot complete path��������·��
% figure
path=[n(1:2)]; % ��Դ��Ϣ����·������ǰnΪ�յ�
prev=n(6);     % ��ǰ��ĸ��ڵ��Ӧ��closed����
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

