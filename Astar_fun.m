function dis=Astar_fun(A,B,sign)
[row,col]=size(sign);
notCross = 1; % M�в���ͨ���ĵ��ֵ
F = zeros(row,col);
G = zeros(row,col);
mov = [1 0;-1 0; 0 1;0 -1;-1 -1; -1 1; 1 -1; 1 1]; %�˸�����
%mov = [1 0;-1 0; 0 1;0 -1];
opened = A;
closed = [];
parent = zeros(row,col);
inOpen = false(row,col);   % �Ƿ��ڿ����б���
inClose = false(row,col);  % �Ƿ��ڹر��б���
%% ================================================
inOpen(A(1),A(2)) = true;
G(A(1),A(2)) = 0;
F(A(1),A(2)) =sum(abs(A-B));
[index,min_num] = minInOpen(opened,F);

while min_num(1)~=B(1)||min_num(2)~=B(2)   %��������(Ҳ�����յ㱻���뵽)��
    opened(index,:) = [];     %�ӿ����б���ɾ��
    inOpen(min_num(1), min_num(2)) = false;
    closed = [closed;min_num];
    inClose(min_num(1), min_num(2)) = true;
    
    % ����8�����и����fn��gn��hn��
    for i=1:size(mov,1)
        temp = min_num + mov(i,:);
        if temp(1)<=row&&temp(1)>0&&temp(2)<=col&&temp(2)>0
            if sign(temp(1),temp(2)) ~= notCross&&inClose(temp(1),temp(2)) == false      % �õ����ͨ���Ҳ��ڷ���б���
                if mov(i,1)==0||mov(i,2)==0
                    if inOpen(temp(1),temp(2)) == 0    %  ���ڿ����б��У�����open
                        parent(temp(1),temp(2)) = (min_num(2)-1)*row+ min_num(1);
                        opened = [opened;temp];
                        G(temp(1),temp(2)) = G(min_num(1),min_num(2))+norm(min_num-temp);
                        F(temp(1),temp(2)) = G(temp(1),temp(2))+sum(abs(temp-B));
                        inOpen(temp(1), temp(2)) = true;
                    else           % �ڿ����б���
                        gnn = norm(min_num-temp) + G(min_num(1),min_num(2)); %
                        if gnn < G(temp(1),temp(2))
                            parent(temp(1),temp(2)) = (min_num(2)-1)*row+ min_num(1);
                            G(temp(1),temp(2))=gnn;
                            F(temp(1),temp(2)) = G(temp(1),temp(2))+sum(abs(temp-B));
                        end
                    end
                elseif sign(min_num(1)+mov(i,1),min_num(2)) ~= notCross&&sign(min_num(1),min_num(2)+mov(i,2)) ~= notCross
                    if inOpen(temp(1),temp(2)) == 0    %  ���ڿ����б��У�����open
                        parent(temp(1),temp(2)) = (min_num(2)-1)*row+ min_num(1);
                        opened = [opened;temp];
                        G(temp(1),temp(2)) = G(min_num(1),min_num(2))+norm(min_num-temp);
                        F(temp(1),temp(2)) = G(temp(1),temp(2))+sum(abs(temp-B));
                        inOpen(temp(1), temp(2)) = true;
                    else           % �ڿ����б���
                        gnn = norm(min_num-temp) + G(min_num(1),min_num(2)); %
                        if gnn < G(temp(1),temp(2))
                            parent(temp(1),temp(2)) = (min_num(2)-1)*row+ min_num(1);
                            G(temp(1),temp(2))=gnn;
                            F(temp(1),temp(2)) = G(temp(1),temp(2))+sum(abs(temp-B));
                        end
                    end
                end
            end
        end
    end
    [index,min_num] = minInOpen(opened,F);
end
dis=G(B(1),B(2));
% % ������·��
% route =[B];
% t=parent(B(1),B(2));
% indA = (A(2)-1)*row+ A(1);
% while t ~=  indA
%     [pc(1),pc(2)] = ind2sub([row,col],t);
%     route = [route;pc];
%     t=parent(t);
% end
% route = [route;A];
% route=flipud(route);

