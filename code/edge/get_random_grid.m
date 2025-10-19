function [sourse, target] = get_random_grid(Dim, d_prime, n_Point, int_len, far_distance)
    sourse = int_len * rand(n_Point, Dim);
    target = int_len * rand(n_Point, Dim);
    target(:, d_prime+1:Dim) = target(:, d_prime+1:Dim) + far_distance;  
    

    sourse = sort(sourse)';
    target = sort(target)';
end
