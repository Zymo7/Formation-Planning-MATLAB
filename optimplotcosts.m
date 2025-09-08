function stop = optimplotcosts(x,optimValues,state)
    stop = false;
    switch state
        case 'init'
            hold on;
            title('Costs vs Iterations');
            xlabel('Iterations');
            ylabel('Costs');
            legend('cost1','cost2','cost3');
            cost1_values = [];
            cost2_values = [];
            cost3_values = [];
        case 'iter'
            [c, cost1, cost2, cost3] = cost(x, H, t, new_path, num);
            cost1_values = [cost1_values; cost1];
            cost2_values = [cost2_values; cost2];
            cost3_values = [cost3_values; cost3];
            plot(cost1_values, 'r');
            plot(cost2_values, 'g');
            plot(cost3_values, 'b');
        case 'done'
            hold off;
    end
end