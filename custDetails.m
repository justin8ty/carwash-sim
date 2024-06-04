function [intArrival, service] = custDetails(n, r, loopNum, m, a, c) 
   % This function generates random details for n customers 

    intArrival = zeros(1, n); 
    intArrival(1) = 0; 
    service = zeros(1, n); 
    
    if r == 1 
        % Generate random number for inter-arrival time n-1 times and assign to the array 'intArrival'
        for i = 2:n 
            intArrival(i) = randi([1, 100]); 
        end 
        
        % Generate random number for service time n times and assign to the array 'service'
        for i = 1:n 
            service(i) = randi([1, 100]); 
        end 
    
    elseif r == 2
        intArrivalLcg = lcg(loopNum, m, a, c); 
        for i = 2:n
            intArrival(i) = round(intArrivalLcg(i) * 99) + 1; 
        end
        
        serviceTimeLcg = lcg(loopNum, m, a, c); 
        for i = 1:n
            service(i) = round(serviceTimeLcg(i) * 99) + 1; 
        end 
        
    elseif r == 3 
        for i = 2:n 
            intArrival(i) = mod(round(rvge(loopNum) * 99), 100) + 1; 
        end 
        for i = 1:n 
            service(i) = mod(round(rvge(loopNum) * 99), 100) + 1; 
        end 
        
    elseif r == 4 
        for i = 2:n 
            intArrival(i) = mod(round(rvgu(loopNum) * 99), 100) + 1; 
        end 
        for i = 1:n 
            service(i) = mod(round(rvgu(loopNum) * 99), 100) + 1; 
        end 
        
    else 
        fprintf('Invalid random generator selection\n'); 
        return 
    end 
end 
