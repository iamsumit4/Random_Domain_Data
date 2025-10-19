function [K, r] = generate_kernel_matrix_and_get_rank(X,Y, kernel_choice, tol)
    [Dim, n_Point] = size(X);
    N = n_Point^Dim;
    K = zeros(N);

    if Dim == 1
        source_xx = ndgrid(Y(1,:)); 
        target_xx = ndgrid(X(1,:));
        source_xx = source_xx(:); 
        target_xx = target_xx(:);
        K = zeros(N);
        for i = 1:N
            K(:,i)  =  (source_xx - target_xx(i)).^2;
        end
        K = sqrt(K);
    elseif Dim == 2
        [target_xx,target_yy] = ndgrid(X(1,:),X(2,:)); 
        [source_xx,source_yy] = ndgrid(Y(1,:),Y(2,:));
        target_xx = target_xx(:); 
        source_xx = source_xx(:);
        target_yy = target_yy(:); 
        source_yy = source_yy(:);
        K = zeros(N);
        for i = 1:N
            K(:,i)  =  (target_xx - source_xx(i)).^2 + (target_yy - source_yy(i)).^2;
        end
        K = sqrt(K);
    elseif Dim == 3
        [target_xx, target_yy, target_zz] = ndgrid(X(1,:), X(2,:), X(3,:)); 
        [source_xx, source_yy, source_zz] = ndgrid(Y(1,:), Y(2,:), Y(3,:));
        target_xx = target_xx(:); 
        source_xx = source_xx(:);
        target_yy = target_yy(:); 
        source_yy = source_yy(:);
        target_zz = target_zz(:); 
        source_zz = source_zz(:);
        K = zeros(N);
        for i = 1:N
            K(:,i)  =  (target_xx - source_xx(i)).^2 + (target_yy - source_yy(i)).^2 + (target_zz - source_zz(i)).^2;
        end
        K = sqrt(K);
    elseif Dim == 4
        [target_xx, target_yy, target_zz, target_tt] = ndgrid(X(1,:), X(2,:), X(3,:), X(4,:)); 
        [source_xx, source_yy, source_zz, source_tt] = ndgrid(Y(1,:), Y(2,:), Y(3,:), Y(4,:));
        target_xx = target_xx(:); 
        source_xx = source_xx(:);
        target_yy = target_yy(:); 
        source_yy = source_yy(:);
        target_zz = target_zz(:); 
        source_zz = source_zz(:);
        target_tt = target_tt(:); 
        source_tt = source_tt(:);
        K = zeros(N);
        for i = 1:N
            K(:,i)  =  (target_xx - source_xx(i)).^2 + (target_yy - source_yy(i)).^2 + (target_zz - source_zz(i)).^2 + + (target_tt - source_tt(i)).^2;
        end
        K = sqrt(K);
    else
        disp('Grid is not defined is not defined yet.');
    end
    K = ker_fun(K, kernel_choice);
    r = get_rank(K,tol);
    % r = perform_ppACA_rank(K,tol);
end
