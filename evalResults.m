function evalResults(intArrival, svcTime)
    % # of customers
    n = length(intArrival);

    avgIntArrival = mean(intArrival);
    arrival = cumsum(intArrival);

    % Waiting time for each customer
    % n rows, 1 column
    waiting = zeros(n, 1);
    waiting(1) = 0;
    for i = 2:n
        waiting(i) = max(0, arrival(i) - (arrival(i-1) + svcTime(i-1)));
    end

    avgArrival = mean(arrival);
    avgWaiting = mean(waiting);
    timeSpent = waiting + svcTime;
    avgTimeSpent = mean(timeSpent);
    probWaiting = sum(waiting > 0) / n;
    avgService = mean(svcTime);

    % Display the results
    fprintf('---------- Simulation Results ----------\n\n');
    fprintf('Avg.  Inter-Arrival Time:     %.2f\n', avgIntArrival);
    fprintf('Avg.  Arrival Time:           %.2f\n', avgArrival);
    fprintf('Avg.  Waiting Time:           %.2f\n', avgWaiting);
    fprintf('Avg.  Time Spent:             %.2f\n', avgTimeSpent);
    fprintf('Prob. of Waiting in Queue:    %.2f\n', probWaiting);
    fprintf('Avg.  Service Time / Counter: %.2f\n', avgService);
end
