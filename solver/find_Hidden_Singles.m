function result = find_Hidden_Singles(sudoku)
    result = [];
    [num_choices, choices] = find_possible_fillins(sudoku);
    % if there exists some cell with only one possible choice
    index = find(num_choices==1, 1);
    if (~isempty(index))
        [r, c]=ind2sub(size(num_choices),index);
        choice = choices{r,c}(1);
        result = [r, c, choice];
    end
end