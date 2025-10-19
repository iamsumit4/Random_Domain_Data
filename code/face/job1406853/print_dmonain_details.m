function print_dmonain_details(d_prime, far_distance)
    if d_prime == 0 && far_distance == 0
        fprintf('The domains are identical.\n');
    elseif d_prime == 0 && far_distance == 1
        fprintf('The domains share a vertex.\n');
    elseif d_prime == 1 && far_distance == 1
        fprintf('The domains share an edge.\n');
    elseif d_prime == 2 && far_distance == 1
        fprintf('The domains share a face.\n');
    elseif d_prime > 2 && far_distance == 1
        fprintf('The domains share a %d dimentianal hypersurface.\n', d_prime);
    elseif far_distance > 1 && (d_prime == 0 || d_prime == 1)
        fprintf('The domains are farfield.\n');
    end
end
