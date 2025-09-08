% formula 8.1
function [isok,t,u,v] = LpSpLp(x,y,phi)
    [t,u] = cart2pol(x-sin(phi),y-1+cos(phi)); % ���ѿ�������ת��Ϊ������,����theta��rho,���ķ��ص���[u,t],����Ϊcart2pol�������ص�ֵ��˳��ͬ������ԭ�Ĳ�ͬ����������ĺ��廹��һ����t�����ȣ�u����ֱ�еľ���
    if t >= 0 % ��������ת,t>=0������ת
        v = mod2pi(phi-t);
        if v >= 0 % ���Ŵ���ǰ���ͺ���
            isok = true;
            return
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end