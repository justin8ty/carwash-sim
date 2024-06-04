function evalResults(intArrival, service)
{
    % # of customers
    n = length(intArrival);

    avgIntArrival = mean(intArrival);
    arrival = cumsum(intArrival);

    % Waiting time for each customer
    % n rows, 1 column
    waiting = zeros(n, 1);
    waiting(1) = 0;
    for i = 2:n
        waiting(i) = max(0, arrival(i) - (arrival(i-1) + service(i-1)));
    end

    avgWaiting = mean(waiting);
    timeSpent = waiting + service;
    avgTimeSpent = mean(timeSpent);
    probWaiting = sum(waiting > 0) / n;
    avgService = mean(service);


    fprintf('Simulation Results:\n');
    fprintf('Avg. Inter-Arrival Time: %.2f\n', avgIntArrival);
    fprintf('Avg. Waiting Time: %.2f\n', avgWaiting);
    fprintf('Avg. Arrival Time: %.2f\n', avgArrival);
    fprintf('Avg. Time Spent: %.2f\n', avgTimeSpent);
    fprintf('Prob. of Waiting in Queue: %.2f\n', probWaiting);
    fprintf('Avg. Service Time / Counter: %.2f\n', avgService);
}

% Average inter-arrival time
% Average arrival time
% Average waiting time
% Probability of waiting in the queue
% Total time spent in the system
