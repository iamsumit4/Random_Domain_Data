function rank = get_rank(K, tol)
    % Perform Singular Value Decomposition
    [~, S, ~] = svd(K, 'econ');
    
    % Extract the singular values
    singularValues = diag(S);
    
    % The maximum singular value
    maxSingularValue = singularValues(1);
    
    % Count the number of singular values greater than tol * maxSingularValue
    rank = sum(singularValues > tol * maxSingularValue);
end
