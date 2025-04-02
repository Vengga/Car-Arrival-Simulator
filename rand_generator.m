function rand_numbers = rand_generator(seed, a, c, m, n)
    % Function to generate a sequence of random numbers using a linear congruential generator (LCG)
    % seed: initial value (the seed)
    % a: multiplier
    % c: increment
    % m: modulus
    % n: number of random numbers to generate

    rand_numbers = zeros(1, n); % Initialize the array to store random numbers with zeros
    rand_numbers(1) = seed; % Set the first element of the array to the seed

    for i = 2:n % Loop to generate the rest of the random numbers
        rand_numbers(i) = mod(a * rand_numbers(i-1) + c, m); % Apply the Linear Congruential Generator formula
    end

    rand_numbers = rand_numbers / m; % Normalize the random numbers to be between 0 and 1
end
