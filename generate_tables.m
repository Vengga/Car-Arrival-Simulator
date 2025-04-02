function [service_time_table, inter_arrival_time_table] = generate_tables()
    % Function to generate tables for service times and inter-arrival times
    
    % Create the service time table as a cell array
    service_time_table = {
        1, 5, 0.5, 0.5, '[0, 0.5)';    % Row for service type 1, time 5, probability 0.5, cumulative 0.5, range [0, 0.5)
        1, 10, 0.3, 0.8, '[0.5, 0.8)'; % Row for service type 1, time 10, probability 0.3, cumulative 0.8, range [0.5, 0.8)
        1, 15, 0.2, 1.0, '[0.8, 1.0)'; % Row for service type 1, time 15, probability 0.2, cumulative 1.0, range [0.8, 1.0)
        2, 6, 0.4, 0.4, '[0, 0.4)';    % Row for service type 2, time 6, probability 0.4, cumulative 0.4, range [0, 0.4)
        2, 12, 0.4, 0.8, '[0.4, 0.8)'; % Row for service type 2, time 12, probability 0.4, cumulative 0.8, range [0.4, 0.8)
        2, 18, 0.2, 1.0, '[0.8, 1.0)'; % Row for service type 2, time 18, probability 0.2, cumulative 1.0, range [0.8, 1.0)
        3, 7, 0.3, 0.3, '[0, 0.3)';    % Row for service type 3, time 7, probability 0.3, cumulative 0.3, range [0, 0.3)
        3, 14, 0.5, 0.8, '[0.3, 0.8)'; % Row for service type 3, time 14, probability 0.5, cumulative 0.8, range [0.3, 0.8)
        3, 21, 0.2, 1.0, '[0.8, 1.0)'  % Row for service type 3, time 21, probability 0.2, cumulative 1.0, range [0.8, 1.0)
    };

    % Create the inter-arrival time table as a cell array
    inter_arrival_time_table = {
        3, 0.4, 0.4, '[0, 0.4)';    % Row for inter-arrival time 3, probability 0.4, cumulative 0.4, range [0, 0.4)
        6, 0.4, 0.8, '[0.4, 0.8)';  % Row for inter-arrival time 6, probability 0.4, cumulative 0.8, range [0.4, 0.8)
        9, 0.2, 1.0, '[0.8, 1.0)'   % Row for inter-arrival time 9, probability 0.2, cumulative 1.0, range [0.8, 1.0)
    };
end
