function [num_choices, choices] = find_possible_fillins(sudoku)
    % This function is used to find the valid fillin for every empty cell.
    % Input:
    % - sudoku: a 9*9 matrix filled with 0,1-9, (0 stands for empty cell)
    % Outputs:
    % - num_choices: # of possible fillins for each empty cell.(9 stands
    %                for filled cell)
    % - choices:     possible fillins for each empty cell. (in array)
    
    choices = cell(9,9);
    num_choices = 9*ones(9);
    for i =1:9
        for j =1:9
            if (sudoku(i,j)>0)
                continue
            end
            % the i-th row
            row = sudoku(i,:);
            % the j-th col
            col = sudoku(:,j)';

            % the (ii,jj)-th box
            ii = fix((i-1)/3); jj = fix((j-1)/3);
            box = sudoku(ii*3+1:ii*3+3, jj*3+1:jj*3+3);
            box = reshape(box,1,9);

            existing = union(union(row,col),box);
            fillins = setdiff(1:9,existing);
            num_choices(i,j) = length(fillins);
            choices{i,j} = fillins;
        end
    end
end