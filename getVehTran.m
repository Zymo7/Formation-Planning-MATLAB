% ���ݺ������ĵ�λ�˼��㳵���߿��λ��
function [x,y] = getVehTran(x,y,theta)
    W = 0.4;
    LF = 0.1;
    LB = 0.1;
    % �����ı߿����ĸ��ǵ�ȷ��
    Cornerfl = [LF, W/2]; % ��ǰ���ǵ�
    Cornerfr = [LF, -W/2]; % ��ǰ���ǵ�
    Cornerrl = [-LB, W/2]; % ��󷽽ǵ�
    Cornerrr = [-LB, -W/2]; % �Һ󷽽ǵ�
    Pos = [x,y]; % ������������
    dcm = angle2dcm(-theta, 0, 0); % �����ĸ��ǵ����ת����,�����Ǹ����һ���֣���ת������ͬ�����Ƕ�ת��Ϊ�������Ҿ�����ת˳����ZYX
    
    tvec = dcm*[Cornerfl';0]; % ��ת�任��Cornerfl��ת���γɵ���������λ������3*1�����һ����z����
    tvec = tvec';
    Cornerfl = tvec(1:2)+Pos; % ƽ�Ʊ任
    
    tvec = dcm*[Cornerfr';0];
    tvec = tvec';
    Cornerfr = tvec(1:2)+Pos;
    
    tvec = dcm*[Cornerrl';0];
    tvec = tvec';
    Cornerrl = tvec(1:2)+Pos;
    
    tvec = dcm*[Cornerrr';0];
    tvec = tvec';
    Cornerrr = tvec(1:2)+Pos;
    
     
    % ���س����߿��ĸ��ǵ��x,y����
    x = [Cornerfl(1),Cornerfr(1),Cornerrr(1),Cornerrl(1),Cornerfl(1)];
    y = [Cornerfl(2),Cornerfr(2),Cornerrr(2),Cornerrl(2),Cornerfl(2)];
%     patch(x,y,[1 1 0])
end