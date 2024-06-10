function output = main(n, r, loopNum, m, a, c)
    % for testing, try main (5, r, 6, 1, 5, 7)
    
    % n = number of customers
    % r = 1: rand
    % r = 2: lcg(m = mod, a = multiplier, c = additive)
    % r = 3: rvge (random variate generator for exponential distribution)
    % r = 4: rvgu (random variate generator for uniform distribution)
    % loopNum is the number of columns in service time table
    
    [interArrival, svcTime] = custDetails(n, r, loopNum, m, a, c); %passing two arrays from custDetails
    
    %array of ranges generated for service time
    rangeCounter = zeros(3, loopNum) ;
    
    for counterNum = 1:3
        probability = probGenerator(r, loopNum, m, a, c) ;
        rangeCounter (counterNum, :) = counter (loopNum, counterNum, probability, rangeCounter);
    end
    
    %array of ranges generated for inter arrival time
    rangeArrival = zeros(1, 4);
    rangeArrival = interTable(r, loopNum, m, a, c, rangeArrival);
    
    numOfItems = zeros(1, n);
    for i = 1:n
        numOfItems(i) =randi(1, 10);
    end
    
    customer = zeros(1, n);
    custArrival = zeros(1, n); %inter-arrival time for each customer
    
    clock = 0; %set timer
    custArrival (1) = clock; %customer 1 arrives at time 0;
    
    %comparing RN to inter arrival ranges
    for i = 2:n
        if (interArrival(i) >= 0 && interArrival(i) <= rangeArrival (1))
            custArrival(i) = 1;
        elseif (interArrival (i) >= rangeArrival(1) + 1 && interArrival (i) <= rangeArrival (2))
            custArrival(i) = 2;
        elseif (interArrival(i) >= rangeArrival(2) + 1 && interArrival(i) <= rangeArrival(3))
            custArrival(i) = 3;
        elseif (interArrival (i) >= rangeArrival(3) + 1 && interArrival (i) <= rangeArrival (4))
            custArrival(i) = 4;
        else
            fprintf ('error\n');
        end

    end
            
    clockRecord = zeros(1, n);
    clockRecord (1) = 0; %record first arrival time as 0
    
    fprintf('\n');
    fprintf ('| n | RN | Inter-arrival time | Arrival time | Number of items |\n');
    fprintf ('| 1 | -- | 0 | 0 | %2d |\n', numOfItems(1));
        
    clock = clock + custArrival (2); %clock is set to customer 2's inter-arrival time
    clockRecord (2) = clock; %record second arrival time
    
    for i = 2:n-1
        fprintf ('| %d | %2d | %2d | %2d | %2d |\n', i ,interArrival(i), custArrival(i), clock, numOfItems(i));
        clockRecord(i) = clock;
        clock = clock + custArrival(i+1);
    end
        
    fprintf ('| %d | %2d | %2d | %2d | %2d |\n', i ,interArrival(n), custArrival(n), clock, numOfItems(n));
    clockRecord (n) = clock; %record clock for last customer
        
    fprintf('\n');
        
    queue1 = []; %arrays for queues of each counter
    queue2 = [];
    queue3 = [];

    for i = 1:n
        if numOfItems (i) <= 3
            queue3(end+1) = i; % add customer to queue 3
            disp (['Customer ', num2str(i), ' arrives at ', num2str(clockRecord (i)), ' and queue at Counter 3']);
        elseif numel (queue1) <= numel (queue2)
            queue1(end+1) = i; % add customer to queue 1
            disp (['Customer ', num2str(i), ' arrives at ', num2str(clockRecord (i)), ' and queue at Counter 1']);
        else
            queue2(end+1) = i; % add customer to queue 2
            disp (['Customer ', num2str(i), ' arrives at ', num2str(clockRecord (i)), ' and queue at Counter 2']);
        end
    end
        
    custServ = zeros(1, n) ;
    
    location = zeros(1, 5); %use to check location of customer
    
    %finding location of each customer
    for i = 1:n
        if any (queue1 == i)
            location(i) = 1;
        elseif any(queue2 == i)
            location(i) = 2;
        elseif any(queue3 == i)
            location(i) = 3;
        else
            fprintf ('error\n');
        end
    end
        
        timeSvcBegins = zeros(1, n);
        timeSvcEnds = zeros(1, n);
        
    %finding RN in the ranges generated for each counter's service time
    for i = 1:n
        if location (i) == 1
            if (svcTime(i) >= 0 && svcTime(i) <= rangeCounter(1, 1))
                custServ(i) = 1;
            elseif (svcTime(i) >= rangeCounter(1, 1) + 1 && svcTime(i) <= rangeCounter(1, 2))
                custServ(i) = 2;
            elseif (svcTime(i) >=rangeCounter(1, 2) + 1 && svcTime(i) <= rangeCounter(1, 3))
                custServ(i) = 3;
            elseif (svcTime(i) >= rangeCounter(1, 3) + 1 && svcTime(i) <= rangeCounter(1, 4))
                custServ(i) = 4;
            elseif (svcTime(i) >= rangeCounter(1, 4) + 1 && svcTime(i) <= rangeCounter(1, 5))
                custServ(i) = 5;
            elseif (svcTime(i) >= rangeCounter(1, 5) + 1 && svcTime(i) <= rangeCounter(1, 6))
                custServ(i) = 6;
            else
                fprintf('error\n');
            end
        elseif location(i) == 2
            if (svcTime(i) >= 0 && svcTime(i) <= rangeCounter(2, 1))
                custServ(i) = 1;
            elseif (svcTime(i) >= rangeCounter(2, 1) + 1 && svcTime(i) <= rangeCounter(2, 2))
                custServ(i) = 2;
            elseif (svcTime(i) >= rangeCounter(2, 2) + 1 && svcTime(i) <= rangeCounter(2, 3))
                custServ(i) = 3;
            elseif (svcTime(i) >= rangeCounter(2, 3) + 1 && svcTime(i) <= rangeCounter (2, 4))
                custServ(i) = 4;
            elseif (svcTime(i) >= rangeCounter(2, 4) + 1 && svcTime(i) <= rangeCounter (2, 5))
                custServ(i) = 5;
            elseif (svcTime(i) >= rangeCounter(2, 5) + 1 && svcTime(i) <= rangeCounter (2, 6))
                custServ(i) = 6;
            else
                fprintf('error\n');
            end
        elseif location(i) == 3
            if (svcTime(i) >= 0 && svcTime(i) <= rangeCounter(3, 1))
                custServ(i) = 1;
            elseif (svcTime(i) >= rangeCounter(3, 1) + 1 && svcTime(i) <= rangeCounter(3, 2) )
                custServ(i) = 2;
            elseif (svcTime(i) >= rangeCounter(3, 2) + 1 && svcTime(i) <= rangeCounter(3, 3))
                custServ(i) = 3;
            elseif (svcTime(i) >= rangeCounter(3, 3) + 1 && svcTime(i) <= rangeCounter(3, 4))
                custServ(i) = 4;
            elseif (svcTime(i) >= rangeCounter(3, 4) + 1 && svcTime(i) <= rangeCounter(3, 5))
                custServ(i) = 5;
            elseif (svcTime(i) >= rangeCounter(3, 5) + 1 && svcTime(i) <= rangeCounter(3, 6))
                custServ(i) = 6;
            else
                fprintf('error\n');
            end
        else
            fprintf('error hahaha\n');
        end
        
        if custServ(i) > 0
            timeSvcBegins (i) = clockRecord(i);
            timeSvcEnds (i) = timeSvcBegins(i) + custServ(i);
        end      
    end
    for i=2:numel (queue1)
        if timeSvcBegins (queue1 (i)) < timeSvcEnds(queue1(i-1));
            timeSvcBegins (queue1 (i)) = timeSvcEnds(queue1(i-1));
            timeSvcEnds (queue1 (i)) = timeSvcEnds(queue1(i-1)) + custServ(queue1(i));
        else
        end
    end
        
    for i=2:numel (queue2)
        if timeSvcBegins (queue2 (i)) < timeSvcEnds (queue2(i-1));
            timeSvcBegins (queue2 (i)) = timeSvcEnds(queue2(i-1));
            timeSvcEnds (queue2 (i)) = timeSvcEnds (queue2 (i-1)) + custServ(queue2(i));
        else
        end
    end
        
    for i=2:numel (queue3)
        if timeSvcBegins (queue3 (i)) < timeSvcEnds(queue3(i-1));
            timeSvcBegins (queue3 (i)) = timeSvcEnds (queue3(i-1));
            timeSvcEnds (queue3(i)) = timeSvcEnds(queue3(i-1)) + custServ(queue3(i));
        else
        end
    end
        
    %calculating waiting time and time spent
    waitingTime = zeros(1,n);
        for i = 1:n
            waitingTime(i) = timeSvcBegins (i) - clockRecord(i);
        end
        
    timeSpend = zeros(1,n) ;
    for i =1:n
        timeSpend(i) = waitingTime(i) + custServ(i);
    end
        
    %displaying messages
    for i=1:length (timeSvcEnds);
        disp(['Departure of customer ', num2str(i), 'at ', num2str(timeSvcEnds(i))]);
    end
        
    for i=1:length (timeSvcBegins) ;
        disp(['Service of customer ', num2str(i), ' begins at ', num2str(timeSvcBegins(i))]);
    end

        
    fprintf('\n');
    fprintf('Counter 1\n');
    fprintf('| n | RN.Service | Service time | Time Service Begins| Time Service Ends| Waiting Time| Time Spent|\n');
    for i = 1:numel (queue1) %going through every value in queue1
        customerNum = queue1(i);
        fprintf ('| %3d | %5d | %4d | %6d | %6d | %6d | %6d I\n', customerNum, svcTime (customerNum), custServ(customerNum), timeSvcBegins (customerNum), waitingTime (customerNum), timeSpend (customerNum));
    end

    fprintf('\n');
    fprintf('Counter 2\n');
    fprintf('| n | RN.Service | Service time | Time Service Begins| Time Service Ends| Waiting Time| Time Spent|\n');
    for i = 1:numel (queue2) %going through every value in queue2
        customerNum = queue2(i);
        fprintf ('| %3d | %5d | %4d | %6d | %6d | %6d | %6d I\n', customerNum, svcTime (customerNum), custServ(customerNum), timeSvcBegins (customerNum), waitingTime (customerNum), timeSpend (customerNum));
    end

    fprintf('\n');
    fprintf('Counter 3\n');
    fprintf('| n | RN.Service | Service time | Time Service Begins| Time Service Ends| Waiting Time| Time Spent|\n');
    for i = 1:numel (queue3) %going through every value in queue2
        customerNum = queue3(i);
        fprintf ('| %3d | %5d | %4d | %6d | %6d | %6d | %6d I\n', customerNum, svcTime (customerNum), custServ(customerNum), timeSvcBegins (customerNum), waitingTime (customerNum), timeSpend (customerNum));
    end

    fprintf('\n');
    evalResults(interArrival, svcTime);
    output = 'Simulation completed.';
end