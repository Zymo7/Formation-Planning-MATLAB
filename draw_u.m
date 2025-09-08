figure
subplot(2,1,1)
plot(u(:,1),'r')
hold on
plot(u(:,3),'g')
hold on
plot(u(:,5),'b')
xlabel('t(s)');
ylabel('v(m/s)');
ylim([0,1])
legend('UGV1','UGV2','UGV3')
title('Linear Speed')

subplot(2,1,2)
plot(u(:,2),'r')
hold on
plot(u(:,4),'g')
hold on
plot(u(:,6),'b')
xlabel('t(s)');
ylabel('w(rad/s)');
ylim([-1,1])
legend('UGV1','UGV2','UGV3')
title('Angular Speed')