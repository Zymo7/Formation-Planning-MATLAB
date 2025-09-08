formation_cost = formation_cost(:,1);
error = zeros(H-1,1);
for i = 2 : H-1
    error(i,1) = (formation_cost(i)-formation_cost(i-1));
end
figure
plot(error,'r')
xlabel('t(s)')
ylabel('formation error')