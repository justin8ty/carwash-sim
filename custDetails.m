function [intArrival, svcTime] = custDetails(n, r, loopNum, m, a, c)
    % This function generates random details for n customers

    intArrival = zeros(1, n);
    intArrival(1) = 0;
    svcTime = zeros(1, n);
    
    if r == 1
        % Generate random number for inter-arrival time n-1 times and assign to the array 'intArrival'
        for i = 2:n
            intArrival(i) = randi([1, 100]);
        end
        
        % Generate random number for svcTime time n times and assign to the array 'svcTime'
        for i = 1:n
            svcTime(i) = randi([1, 100]);
        end
    
    elseif r == 2
        intArrivalLcg = lcg(n, m, a, c);
        for i = 2:n
            intArrival(i) = round(intArrivalLcg(i) * 99) + 1;
        end
        
        svcTimeLcg = lcg(n, m, a, c);
        for i = 1:n
            svcTime(i) = round(svcTimeLcg(i) * 99) + 1;
        end
        
    elseif r == 3
        intArrivalRvge = rvge(n);
        for i = 2:n
            intArrival(i) = mod(round(intArrivalRvge(i) * 99), 100) + 1;
        end
        
        svcTimeRvge = rvge(n);
        for i = 1:n
            svcTime(i) = mod(round(svcTimeRvge(i) * 99), 100) + 1;
        end
        
    elseif r == 4
        intArrivalRvgu = rvgu(n);
        for i = 2:n
            intArrival(i) = mod(round(intArrivalRvgu(i) * 99), 100) + 1;
        end
        
        svcTimeRvgu = rvgu(n);
        for i = 1:n
            svcTime(i) = mod(round(svcTimeRvgu(i) * 99), 100) + 1;
        end
        
    else
        fprintf('Invalid random generator selection\n');
        return
    end
end
