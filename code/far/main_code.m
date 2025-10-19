clear;
clc;

opengl('save', 'software');

% Disable figure visibility since the code is running in a headless environment
set(0, 'DefaultFigureVisible', 'off');

kernel_choice = 'kernel_1';
% Kernel choice:
% 'kernel_1' = 1/r             'kernel_2' = log r
% 'kernel_3' = sin r           'kernel_4' = exp(ir)/r
% 'kernel_5' = 1/sqrt(1 + r)   'kernel_6' = exp(-r)
% 'kernel_7' = r

Dim = 3;
d_prime = 0;

n_Point = [6,8,11,13,16,20];  % Number of particles along each direction.
% For 2D choose [15,22,31,44,63,90,127,179]
% For 3D choose [6,8,11,13,16,20,25,32]
N_values = n_Point.^Dim; % Total number of particles in each domain.

total_Num_of_Exp = 2000;
tol = 1e-12;

int_len = 1;
far_distance = 2;
fprintf('\n-----------------------------------------------------------\n');
fprintf('-----------------------------------------------------------\n');
% Display which kernel is being used
fprintf('\nThe experiment is done for %s.\n', kernel_choice);
fprintf('The domeins are %d-dimentional.\n',Dim);
print_dmonain_details(d_prime, far_distance);
fprintf('\n-----------------------------------------------------------\n');
fprintf('-----------------------------------------------------------\n');


% Check if a parallel pool exists, if not, create a new one 
pool = gcp('nocreate');
numWorkers = 40;
if isempty(pool)
    c = parcluster('local');
    c.NumWorkers = numWorkers;
    parpool(c, numWorkers);
end


% Loop over each value of N
for n_idx = 1 : length(N_values)
    nP = n_Point(n_idx); % Get the current value of n_Point
    N = N_values(n_idx); % Get the current value of N_values
    kappa = floor(log2(N));

    fprintf('Matrix size is = %d x %d \n', N, N);

    % Initialize the rank array for parallel workers
    get_rank_ker_mat = zeros(1, total_Num_of_Exp);

    parfor count = 1 : total_Num_of_Exp
        [X,Y] = get_random_grid(Dim, d_prime, nP, int_len, far_distance);
        [~,get_rank_ker_mat(count)] = generate_kernel_matrix_and_get_rank(X,Y,kernel_choice,tol);
    end
    %%%%%%%%%%%%%%%%% For the matrix K %%%%%%%%%%%%%%%%%%%%
    fprintf('\nMean rank of the Kernel Matrix: %.4f\n', mean(get_rank_ker_mat));
    fprintf('Variance of rank of the Kernel Matrix: %.4f\n\n', var(get_rank_ker_mat));
    fprintf('-----------------------------------------------------------\n');

    % Plot histogram
    figure;
    histogram(get_rank_ker_mat, 'Normalization', 'probability'); % Plot histogram normalized to show probabilities
    title(sprintf('Histogram of Random Rank of the Kernel Matrix (N = %d)', N));
    xlabel('Bins');
    ylabel('Probability');

    % Save the histogram as a file
     saveas(gcf, sprintf('histogram_rank_kernel_matrix_N_%d.png', N));

    % Save the get_rank_ker_mat array to a .mat file
    save(sprintf('get_rank_ker_mat_N_%d.mat', N), 'get_rank_ker_mat');

end
