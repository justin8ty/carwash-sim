function [probability] = probGenerator(r, loopNum, m, a, c)

    probability = zeros(1, loopNum);
    
    if r == 1
        for i=1:loopNum
            probability(i) = rand();
            % normalising so that sum (probability) = 1
            probability = probability / sum(probability);
            probability = round(probability * 100) / 100;
        end
    
    elseif r == 2
        probability= lcg(loopNum,m, a, c);
    
    elseif r == 3
        probability = rvge(loopNum);
    
    elseif r == 4
        probability = rvgu(loopNum);
    
    else
        fprintf('zero \n');
        return
        end

        % normalising so that sum sum(probability) = 1
        probability = probability / sum (probability);
        probability = round(probability * 100) / 100;
        
        % sometimes sum (probability) will not equal 1 because each value is rounded so here the leftover is added to a random value in probability
        if sum(probability) ~= 1
            leftover = 1 -sum(probability);
            index = randi (1, loopNum) ;
            probability(index) = probability(index) + leftover;
        end

        % returns probability
        output = probability;