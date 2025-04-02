% Car Wash Simulator Main File with Weather Impact

% Load service time and inter-arrival time tables
[service_time_table, inter_arrival_time_table] = generate_tables();
disp('WELCOME TO THE CAR WASH SIMULATOR!') % Display welcome message

% Ask the user for the weather condition
weather_condition = input('What is the weather today? [1. Sunny  2. Rainy  3. Cloudy  4. Snowy  5. Hailstorm] Enter the number corresponding to the weather: ');

% Adjust based on weather condition
if weather_condition == 1
    disp('What a nice day to dry the car, get a bottle of water before you leave.'); % Message for sunny weather
elseif weather_condition == 2
    disp('It is rainy, expect fewer cars and different service types.'); % Message for rainy weather
elseif weather_condition == 3
    disp('Normal day, simulation runs as usual.'); % Message for cloudy weather
elseif weather_condition == 4
    disp('Water freezes very quickly to the car''s surface, penetrates into the cracks and can damage both the paint and seals, hence wait for more favorable conditions, THANK YOU.'); % Message for snowy weather
    return; % Exit the script for snowy weather
elseif weather_condition == 5
    disp('OH HAIL NO!!'); % Message for hailstorm weather
    return; % Exit the script for hailstorm weather
else
    error('Invalid weather condition. Please enter a number between 1 and 5.'); % Error message for invalid input
end

% User input
num_cars = input('Enter the number of cars: '); % Prompt user to enter the number of cars

% Adjust the number of cars based on the weather condition
if weather_condition == 2
    adjusted_num_cars = max(1, floor(num_cars * 0.7)); % Reduce the number of cars to 70% if it is rainy
    fprintf('Due to the rainy season, only %d cars are allowed in.\n', adjusted_num_cars);
    num_cars = adjusted_num_cars; % Update the number of cars
end

rand_gen_choice = input('Choose random number generator (1 for Linear Congruential, 2 for Rand): '); % Prompt user to choose RNG

% Validate random number generator choice
if rand_gen_choice ~= 1 && rand_gen_choice ~= 2
    error('Invalid choice for random number generator. Please choose 1 for Linear Congruential or 2 for Rand.'); % Error message for invalid RNG choice
end

% Generate random numbers
if rand_gen_choice == 1
    seed = floor(rand() * 100); % Generate a seed
    a = 1664525; % Multiplier for LCG
    c = 1013904223; % Increment for LCG
    m = 2^32; % Modulus for LCG
    rand_numbers = rand_generator(seed, a, c, m, num_cars * 2); % Generate random numbers using LCG
else
    rand_numbers = rand(1, num_cars * 2); % Generate random numbers using rand function
end

% Initialize arrays
inter_arrival_times = zeros(1, num_cars); % Array for inter-arrival times
arrival_times = zeros(1, num_cars); % Array for arrival times
service_times = zeros(1, num_cars); % Array for service times
waiting_times = zeros(1, num_cars); % Array for waiting times
service_start = zeros(1, num_cars); % Array for service start times
service_end = zeros(1, num_cars); % Array for service end times
service_type = zeros(1, num_cars); % Array for service types

% Simulate car arrivals and service
for i = 1:num_cars
    if i == 1
        arrival_times(i) = 0; % First car arrives at time 0
    else
        % Determine inter-arrival time
        if rand_numbers(i) <= 0.4
            inter_arrival_times(i) = 3; % Inter-arrival time 3 minutes
        elseif rand_numbers(i) <= 0.8
            inter_arrival_times(i) = 6; % Inter-arrival time 6 minutes
        else
            inter_arrival_times(i) = 9; % Inter-arrival time 9 minutes
        end
        arrival_times(i) = arrival_times(i-1) + inter_arrival_times(i); % Calculate arrival time
    end
    
    % Determine service type and time
    if rand_numbers(i + num_cars) <= 0.3
        service_type(i) = 3; % Service type 3
        if rand_numbers(i + num_cars) <= 0.3
            service_times(i) = 7; % Service time 7 minutes
        elseif rand_numbers(i + num_cars) <= 0.8
            service_times(i) = 14; % Service time 14 minutes
        else
            service_times(i) = 21; % Service time 21 minutes
        end
    elseif rand_numbers(i + num_cars) <= 0.7
        service_type(i) = 2; % Service type 2
        if rand_numbers(i + num_cars) <= 0.4
            service_times(i) = 6; % Service time 6 minutes
        elseif rand_numbers(i + num_cars) <= 0.8
            service_times(i) = 12; % Service time 12 minutes
        else
            service_times(i) = 18; % Service time 18 minutes
        end
    else
        service_type(i) = 1; % Service type 1
        if rand_numbers(i + num_cars) <= 0.5
            service_times(i) = 5; % Service time 5 minutes
        elseif rand_numbers(i + num_cars) <= 0.8
            service_times(i) = 10; % Service time 10 minutes
        else
            service_times(i) = 15; % Service time 15 minutes
        end
    end
    
    if i == 1
        service_start(i) = arrival_times(i); % Service start time for the first car
    else
        service_start(i) = max(arrival_times(i), service_end(i-1)); % Service start time for subsequent cars
    end
    service_end(i) = service_start(i) + service_times(i); % Service end time
    waiting_times(i) = service_start(i) - arrival_times(i); % Waiting time
    
    % Display arrival, departure, and service start messages
    fprintf('Arrival of car %d at minute %d\n', i, arrival_times(i));
    fprintf('Service for car %d started at minute %d\n', i, service_start(i));
    fprintf('Departure of car %d at minute %d\n', i, service_end(i));
end

% Display simulation results
disp('Simulation Results:');
disp('*******************************************************');
disp('Car  Arrival  Service Start  Service End  Waiting Time');
disp('-------------------------------------------------------');
for i = 1:num_cars
    fprintf('%-4d %-8d %-14d %-11d %-12d\n', i, arrival_times(i), service_start(i), service_end(i), waiting_times(i));
end
disp('*******************************************************');

% Separate tables based on wash bays
disp('Wash Bay 1:');
disp('*******************************************************');
disp('Car  Arrival  Service Start  Service End  Waiting Time');
disp('------------------------------------------------------');
for i = 1:num_cars
    if service_type(i) == 1
        fprintf('%-4d %-8d %-14d %-11d %-12d\n', i, arrival_times(i), service_start(i), service_end(i), waiting_times(i));
    end
end
disp('*******************************************************');

disp('Wash Bay 2:');
disp('*******************************************************');
disp('Car  Arrival  Service Start  Service End  Waiting Time');
disp('------------------------------------------------------');
for i = 1:num_cars
    if service_type(i) == 2
        fprintf('%-4d %-8d %-14d %-11d %-12d\n', i, arrival_times(i), service_start(i), service_end(i), waiting_times(i));
    end
end
disp('*******************************************************');

disp('Wash Bay 3:');
disp('*******************************************************');
disp('Car  Arrival  Service Start  Service End  Waiting Time');
disp('-------------------------------------------------------');
for i = 1:num_cars
    if service_type(i) == 3
        fprintf('%-4d %-8d %-14d %-11d %-12d\n', i, arrival_times(i), service_start(i), service_end(i), waiting_times(i));
    end
end
disp('*******************************************************');

% Evaluate results
avg_waiting_time = mean(waiting_times); % Calculate average waiting time
avg_inter_arrival_time = mean(diff(arrival_times)); % Calculate average inter-arrival time
avg_service_time = mean(service_times); % Calculate average service time
prob_waiting = sum(waiting_times > 0) / num_cars; % Calculate probability of waiting
avg_time_in_system = mean(service_end - arrival_times); % Calculate average time in system
total_idle_time = sum(diff([0, service_end])) - sum(service_times); % Calculate total idle time
utilization_rate = sum(service_times) / max(service_end); % Calculate utilization rate

% Display evaluation metrics
fprintf('Average Waiting Time: %f\n', avg_waiting_time);
fprintf('Average Inter-Arrival Time: %f\n', avg_inter_arrival_time);
fprintf('Average Service Time: %f\n', avg_service_time);
fprintf('Probability of Waiting: %f\n', prob_waiting);
fprintf('Average Time in System: %f\n', avg_time_in_system);
fprintf('Total Idle Time: %f\n', total_idle_time);
fprintf('Utilization Rate: %f%%\n', utilization_rate * 100);

% Plotting the results
figure; % Create a new figure for plotting
hold on; % Hold on to the current plot
for i = 1:num_cars
    plot([arrival_times(i), service_start(i)], [i, i], 'r', 'LineWidth', 2); % Plot waiting time in red
    plot([service_start(i), service_end(i)], [i, i], 'g', 'LineWidth', 2);  % Plot service time in green
end
xlabel('Time (minutes)'); % Label for x-axis
ylabel('Car Number'); % Label for y-axis
title('Car Wash Simulation Timeline'); % Title of the plot
legend('Waiting Time', 'Service Time'); % Legend for the plot
hold off; % Release the current plot
