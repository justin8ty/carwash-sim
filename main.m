function output = main(n, r, loopNum, m, a, c)
    % for testing, try main (5, r, 6, 1, 5, 7)
    
    % n = number of customers
    % r = 1: rand
    % r = 2: lcg(m = mod, a = multiplier, c = additive)
    % r = 3: rvge (random variate generator for exponential distribution)
    % r = 4: rvgu (random variate generator for uniform distribution)
    % loopNum is the number of columns in service time table
    
    [interArrival, svcTime] = custDetails(n, r, loopNum, m, a, c); % passing two arrays from custDetails
    
    % array of ranges generated for service time
    rangeCounter = zeros(3, loopNum);
    
    for counterNum = 1:3
        probability = probGenerator(r, loopNum, m, a, c);
        rangeCounter(counterNum, :) = counter(loopNum, counterNum, probability, rangeCounter);
    end
    
    % array of ranges generated for inter-arrival time
    rangeArrival = zeros(1, 4);
    rangeArrival = interTable(r, loopNum, m, a, c, rangeArrival);
    
    numOfItems = randi([1, 10], 1, n);
    
    customer = zeros(1, n);
    custArrival = zeros(1, n); % inter-arrival time for each customer
    
    clock = 0; % set timer
    custArrival(1) = clock; % customer 1 arrives at time 0
    
    % comparing RN to inter-arrival ranges
    for i = 2:n
        if interArrival(i) >= 0 && interArrival(i) <= rangeArrival(1)
            custArrival(i) = 1;
        elseif interArrival(i) >= rangeArrival(1) + 1 && interArrival(i) <= rangeArrival(2)
            custArrival(i) = 2;
        elseif interArrival(i) >= rangeArrival(2) + 1 && interArrival(i) <= rangeArrival(3)
            custArrival(i) = 3;
        elseif interArrival(i) >= rangeArrival(3) + 1 && interArrival(i) <= rangeArrival(4)
            custArrival(i) = 4;
        else
            fprintf('error\n');
        end
    end
            
    clockRecord = zeros(1, n);
    clockRecord(1) = 0; % record first arrival time as 0
    
    fprintf('\n');
    fprintf('| n | RN | Inter-arrival time | Arrival time | Number of items |\n');
    fprintf('| 1 | -- | 0                  | 0            | %2d              |\n', numOfItems(1));
        
    clock = clock + custArrival(2); % clock is set to customer 2's inter-arrival time
    clockRecord(2) = clock; % record second arrival time
    
    for i = 2:n-1
        fprintf('| %d | %2d | %2d              | %2d          | %2d             |\n', i, interArrival(i), custArrival(i), clock, numOfItems(i));
        clockRecord(i) = clock;
        clock = clock + custArrival(i+1);
    end
        
    fprintf('| %d | %2d | %2d | %2d | %2d |\n', n, interArrival(n), custArrival(n), clock, numOfItems(n));
    clockRecord(n) = clock; % record clock for last customer
        
    fprintf('\n');
        
    queue1 = []; % arrays for queues of each counter
    queue2 = [];
    queue3 = [];

    for i = 1:n
        if numOfItems(i) <= 3
            queue3(end+1) = i; % add customer to queue 3
            disp(['Customer ', num2str(i), ' arrives at ', num2str(clockRecord(i)), ' and queue at Counter 3']);
        elseif numel(queue1) <= numel(queue2)
            queue1(end+1) = i; % add customer to queue 1
            disp(['Customer ', num2str(i), ' arrives at ', num2str(clockRecord(i)), ' and queue at Counter 1']);
        else
            queue2(end+1) = i; % add customer to queue 2
            disp(['Customer ', num2str(i), ' arrives at ', num2str(clockRecord(i)), ' and queue at Counter 2']);
        end
    end
        
    custServ = zeros(1, n);
    location = zeros(1, n); % use to check location of customer
    
    % finding location of each customer
    for i = 1:n
        if any(queue1 == i)
            location(i) = 1;
        elseif any(queue2 == i)
            location(i) = 2;
        elseif any(queue3 == i)
            location(i) = 3;
        else
            fprintf('error\n');
        end
    end
        
    timeSvcBegins = zeros(1, n);
    timeSvcEnds = zeros(1, n);
        
    % finding RN in the ranges generated for each counter's service time
    for i = 1:n
        if location(i) == 1
            custServ(i) = findServiceTime(svcTime(i), rangeCounter(1, :));
        elseif location(i) == 2
            custServ(i) = findServiceTime(svcTime(i), rangeCounter(2, :));
        elseif location(i) == 3
            custServ(i) = findServiceTime(svcTime(i), rangeCounter(3, :));
        else
            fprintf('error hahaha\n');
        end
        
        if custServ(i) > 0
            timeSvcBegins(i) = clockRecord(i);
            timeSvcEnds(i) = timeSvcBegins(i) + custServ(i);
        end
    end

    % Adjusting service times for queue 1
    for i = 2:numel(queue1)
        if timeSvcBegins(queue1(i)) < timeSvcEnds(queue1(i-1))
            timeSvcBegins(queue1(i)) = timeSvcEnds(queue1(i-1));
            timeSvcEnds(queue1(i)) = timeSvcBegins(queue1(i)) + custServ(queue1(i));
        end
    end
        
    % Adjusting service times for queue 2
    for i = 2:numel(queue2)
        if timeSvcBegins(queue2(i)) < timeSvcEnds(queue2(i-1))
            timeSvcBegins(queue2(i)) = timeSvcEnds(queue2(i-1));
            timeSvcEnds(queue2(i)) = timeSvcBegins(queue2(i)) + custServ(queue2(i));
        end
    end
        
    % Adjusting service times for queue 3
    for i = 2:numel(queue3)
        if timeSvcBegins(queue3(i)) < timeSvcEnds(queue3(i-1))
            timeSvcBegins(queue3(i)) = timeSvcEnds(queue3(i-1));
            timeSvcEnds(queue3(i)) = timeSvcBegins(queue3(i)) + custServ(queue3(i));
        end
    end
        
    % calculating waiting time and time spent
    waitingTime = timeSvcBegins - clockRecord;
    timeSpend = waitingTime + custServ;
        
    % displaying departure messages
    for i = 1:length(timeSvcEnds)
        disp(['Departure of customer ', num2str(i), ' at ', num2str(timeSvcEnds(i))]);
    end
        
    % displaying service begin messages
    for i = 1:length(timeSvcBegins)
        disp(['Service of customer ', num2str(i), ' begins at ', num2str(timeSvcBegins(i))]);
    end
        
    % Displaying detailed results for each counter
    printCounterResults('Counter 1', queue1, svcTime, custServ, timeSvcBegins, timeSvcEnds, waitingTime, timeSpend);
    printCounterResults('Counter 2', queue2, svcTime, custServ, timeSvcBegins, timeSvcEnds, waitingTime, timeSpend);
    printCounterResults('Counter 3', queue3, svcTime, custServ, timeSvcBegins, timeSvcEnds, waitingTime, timeSpend);
        
    evalResults(interArrival, svcTime);
    output = 'Simulation completed.';
end

function serviceTime = findServiceTime(randomValue, range)
    % Determine service time based on ranges
    for i = 1:length(range)
        if randomValue <= range(i)
            serviceTime = i;
            return;
        end
    end
    serviceTime = length(range); % fallback to the highest value
end

function printCounterResults(counterName, queue, svcTime, custServ, timeSvcBegins, timeSvcEnds, waitingTime, timeSpend)
    fprintf('\n%s\n', counterName);
    fprintf('| n | RN.Service | Service time | Time Service Begins | Time Service Ends | Waiting Time | Time Spent |\n');
    for i = 1:numel(queue)
        customerNum = queue(i);
        fprintf('| %3d | %5d | %4d | %6d | %6d | %6d | %6d |\n', ...
            customerNum, svcTime(customerNum), custServ(customerNum), ...
            timeSvcBegins(customerNum), timeSvcEnds(customerNum), ...
            waitingTime(customerNum), timeSpend(customerNum));
    end
end
