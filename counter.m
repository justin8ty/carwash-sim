function rangeCounter=counter (loopNum, counterNum, probability, rangeCounter)
    %this function prints counter details
    
    %setting cdf
    cdf = zeros(1,6);
    cdf(1) = probability (1);
    for i=2:6
        cdf(i) = probability(i) + cdf(i-1);
    end

    %setting range
    range = zeros(1, 6);
    for i = 1:6
        range(i) = cdf(i)*100;
        rangeCounter (counterNum, i) = range(i);    
    end
    
    rangeCounter = range;
    
    disp(' ');
    disp(['Counter ', num2str(counterNum), ':']);
    
    printf ('Service Time|');
    for i=1:loopNum
        printf ('   %d   |', i);
    end
    printf('\n');

    %checking if arrays work
    %disp(cdf);
    %disp(range) ;

    printf('Probability | ');
    for i = 1:length (probability) %probability retrieved from main.m
        printf(' %.2f | ', probability(i));
    end
    printf('\n');

    printf ('CDF     | ');
    for i = 1:length (cdf)
        printf(' %.2f | ', cdf(i));
    end
    printf('\n');

    printf ('Range     | ');
    printf (' 0 -%2d |', range(1));
    for i = 2:length (range)
        printf('%2d-%2d |', range(i-1) + 1, range(i));
    end
    printf('\n');