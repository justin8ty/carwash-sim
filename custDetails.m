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
        intArrivalLcg = lcg(loopNum, m, a, c); 
        for i = 2:n
            intArrival(i) = round(intArrivalLcg(i) * 99) + 1; 
        end
        
        svcTimeTimeLcg = lcg(loopNum, m, a, c); 
        for i = 1:n
            svcTime(i) = round(svcTimeTimeLcg(i) * 99) + 1; 
        end 
        
    elseif r == 3 
        for i = 2:n 
            intArrival(i) = mod(round(rvge(loopNum) * 99), 100) + 1; 
        end 
        for i = 1:n 
            svcTime(i) = mod(round(rvge(loopNum) * 99), 100) + 1; 
        end 
        
    elseif r == 4 
        for i = 2:n 
            intArrival(i) = mod(round(rvgu(loopNum) * 99), 100) + 1; 
        end 
        for i = 1:n 
            svcTime(i) = mod(round(rvgu(loopNum) * 99), 100) + 1; 
        end 
        
    else 
        fprintf('Invalid random generator selection\n'); 
        return 
    end 
end 
