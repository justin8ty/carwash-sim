function output = rvge (loopNum) 
    sequence = rand(1,loopNum) ; 
    x = zeros(1,loopNum) ; 
    
    for i=1:length(sequence) 
        x(i) = (-1/1)*(log(l-sequence(i))); 
    end 
    output = x; 
end 