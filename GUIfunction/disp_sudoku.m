function disp_sudoku(current_data)

for i =1:81
    h = findobj('Tag',strcat('edit',string(i)));
    % initialize
    set(h, 'FontSize', 12.0);
    set(h, 'FontWeight', 'normal');
    set(h, 'string', '');
    
    % set value
    value = current_data(i);
    if value>0
        set(h, 'FontSize', 16.0);
        set(h, 'FontWeight', 'bold');
        set(h, 'string', num2str(value));
    end
end

end