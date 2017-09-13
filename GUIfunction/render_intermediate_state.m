function render_intermediate_state(num_choices, choices)
for i =1:81
    if num_choices(i)>8
        continue
    end
    h = findobj('Tag',strcat('edit',string(i)));
    [r,c] = ind2sub([9,9],i);
    set(h, 'string', join(string(choices{r, c}),''));
end
end