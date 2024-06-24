function evalResults(n, intArrival, svcTime, waitingTime, timeSpend, clock, clockRecord)
    % # of customers
    n = length(intArrival);

    avgIntArrival = mean(intArrival);

    avgArrival = mean(clockRecord);
    avgWaiting = mean(waitingTime);
    avgTimeSpent = mean(timeSpend);
    probWaiting = sum(waitingTime > 0) / n;
    avgService = mean(svcTime);

    % Display the results
    fprintf('---------- Simulation Results ----------\n\n');
    fprintf('Avg.  Inter-Arrival Time:     %.2f\n', avgIntArrival);
    fprintf('Avg.  Arrival Time:           %.2f\n', avgArrival);
    fprintf('Avg.  Waiting Time:           %.2f\n', avgWaiting);
    fprintf('Avg.  Time Spent:             %.2f\n', avgTimeSpent);
    fprintf('Prob. of Waiting in Queue:    %.2f\n', probWaiting);
    fprintf('Avg.  Service Time / Counter: %.2f\n', avgService);

    fprintf('timespent Time:     %.2f\n', timeSpend);
    fprintf('arriv Time:     %.2f\n', clock);
    fprintf('intarr Time:     %.2f\n', intArrival);
    fprintf('wait Time:     %.2f\n', waitingTime);
end
