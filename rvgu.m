function output = rvgu(loopNum)
    %interval a is 0
    %interval b is 1 
    
    sequence = rand(1, loopNum) ; 
    x = zeros(1,loopNum); 
    
    for i=1:length(sequence) 
        x(i) = 0 + (1 - 0)*sequence(i); 
    end 
    output = x; 