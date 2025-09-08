function [index,mc] = minInOpen(open,F)
%MININOPEN    ����open�б���fn��С�Ľڵ�
%   OPENΪ�����б�

index = 0;
mc = 0;
mv =  inf;
for ii=1:size(open,1)
    v = F(open(ii,1),open(ii,2));
    if v<mv
        mv = v;
        mc = open(ii,:);
        index = ii;
    end
end
index = index;
mc = mc;