function rangeCounter=counter (loopNum, counterNum, probability, rangeCounter)
    %this function prints counter details
    
    %setting cdf
    cdf = zeros(1,6);
    cdf(1) = probability(1);
    for i=2:6
        cdf(i) = probability(i) + cdf(i-1);
    end

    %setting range
    range = zeros(1, 6);
    for i = 1:6
        range(i) = ceil(cdf(i)*100);
        rangeCounter(counterNum, i) = range(i);    
    end
    
    rangeCounter = range;
    
    disp(' ');
    disp(['Counter ', num2str(counterNum), ':']);
    
    fprintf('Service Time | ');
    for i=1:loopNum
        fprintf('   %d   |', i);
    end
    fprintf('\n');

    %checking if arrays work
    %disp(cdf);
    %disp(range) ;

    fprintf('Probability  | ');
    for i = 1:length(probability) %probability retrieved from main.m
        fprintf(' %.2f  |', probability(i));
    end
    fprintf('\n');

    fprintf('CDF          | ');
    for i = 1:length(cdf)
        fprintf(' %.2f  |', cdf(i));
    end
    fprintf('\n');

    fprintf('Range        | ');
    fprintf(' 0-%2d  |', range(1));
    for i = 2:length(range)
        fprintf('%2d-%2d  |', range(i-1) + 1, range(i));
    end
    fprintf('\n');