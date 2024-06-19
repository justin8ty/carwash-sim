function output=lcg (loopNum,m,a, c)
    seed = rand(); 
    x = seed; 
    
    n = zeros(1, loopNum); 
    
    for i=1:loopNum 
        n(i) = mod(a*x+c,m); 
        x=n(i); 
    end 
    output =n; 