function [result] = ker_fun(r, kernel_choice)
    if r == 0
        result = 0.0;
    else 
        switch kernel_choice
        case 'kernel_1'
                result = 1 ./ r;
        case 'kernel_2'
            result = log(r);
        case 'kernel_3'
            result = sin(r);
        case 'kernel_4'
            result = exp(1i .* r) ./ r;
        case 'kernel_5'
            result = 1 ./ sqrt(1 + r);
        case 'kernel_6'
            result = exp(-r);
        case 'kernel_7'
            result = r;
        % case 'kernel_8'
        %     result = x .* y; % This will generate a rank 1 matrix
        otherwise
            error('Unknown kernel function selected.');
        end
   end
    
    % Handle Inf and NaN values
    result(isinf(result)) = 0; % Set Infinity values to 0
    result(isnan(result)) = 0; % Set NaN values to 0
end
