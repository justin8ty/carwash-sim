function rangeArrival = interTable(r, loopNum, m, a, c, rangeArrival)
    % This function prints the inter-arrival probability table
    
    loopNum = 4;
    probability = zeros(1, loopNum); % Initialize probability array

    if r == 1
        for i = 1:loopNum
            probability(i) = rand();
        end
        % Normalizing so that sum(probability) = 1
        probability = probability / sum(probability);
        probability = round(probability * 100) / 100;
    elseif r == 2
        probability = lcg(loopNum, m, a, c);
    elseif r == 3
        probability = rvge(loopNum);
    elseif r == 4
        probability = rvgu(loopNum);
    else
        fprintf('zero \n');
        return;
    end

    % Normalizing so that sum(probability) = 1
    probability = probability / sum(probability);
    probability = round(probability * 100) / 100;

    % Sometimes sum(probability) will not equal 1 because each value is rounded
    % Handle leftover by adjusting a random index
    if sum(probability) ~= 1
        leftover = 1 - sum(probability);
        index = randi(loopNum);
        probability(index) = probability(index) + leftover;
    end

    % Setting CDF
    cdf = zeros(1, loopNum);
    cdf(1) = probability(1);
    for i = 2:loopNum
        cdf(i) = probability(i) + cdf(i - 1);
    end

    % Setting range
    range = zeros(1, loopNum);
    for i = 1:loopNum
        range(i) = round(cdf(i) * 100);
        rangeArrival(i) = range(i);
    end

    fprintf('\n');
fprintf('Arrival Time|');
for i = 1:loopNum
    fprintf(' %3d  |', i);
end
fprintf('\n');

fprintf('Probability |');
max_prob_width = max(cellfun(@length, arrayfun(@num2str, probability, 'UniformOutput', false)));
for i = 1:length(probability)
    fprintf(' %.2f |', probability(i));
end
fprintf('\n');

fprintf('CDF         |');
max_cdf_width = max(cellfun(@length, arrayfun(@num2str, cdf, 'UniformOutput', false)));
for i = 1:length(cdf)
    fprintf(' %.2f |', cdf(i));
end
fprintf('\n');

fprintf('Range       |');
max_range_width = max(cellfun(@length, arrayfun(@num2str, range, 'UniformOutput', false)));
fprintf('  0 -%*d |', max_range_width, range(1));
for i = 2:length(range)
    fprintf(' %*d -%*d |', max_range_width, range(i - 1) + 1, max_range_width, range(i));
end
fprintf('\n');
