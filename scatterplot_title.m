function s_fig = scatterplot_title(x, title_string)
    s_fig = scatterplot(x);
    ax = s_fig.CurrentAxes;
    title(ax, title_string);
end
