%%T1D-E003989
x_labels = [55 
80 
87 
137 
165 
208 
243 
271 
303 
346 
403 
437 
474 
531 
637 
659 
684 
724 
750 
791 
835 
915 
986 
1028 
1050 
];
y_values = [0.434684168	1.481325749	0.284695137	0.770624166	0.50386235	0.58066294	0.553443481	9.46495638	8.971050634	8.635742922	5.911533076	4.985494092	6.994349123	7.834099197	6.235134481	6.39513575	7.352069068	6.012955346	7.906405181	7.485935454	10.36895965	10.9291534	8.509214685	9.926861384	11.5088811
];
x_values = 1:length(y_values);

plot(x_values, y_values, 'r-', 'LineWidth', 3);

xticks(1:length(x_labels))
xticklabels(x_labels)
ylabel('MFDN score',FontSize = 15)
title('The score of E003989 ',FontSize = 15)

index_to_mark1 = find(y_values == 9.46495638);
index_to_mark2 = find(y_values == 5.911533076);

hold on; 
plot(index_to_mark1, y_values(index_to_mark1), ...
     'LineStyle', '--', 'LineWidth', 6, 'Marker', 'p', 'Color', '#fb9c4a');
plot(index_to_mark2, y_values(index_to_mark2), ...
     'LineStyle', '--', 'LineWidth', 8, 'Marker', 'o', 'Color', '#599CB4');
y_max = max(y_values) * 1.1;  

ylim([0 y_max])
xlim([1 length(x_labels)])
ax = gca; 
ax.XAxis.TickLabelFormat = '%d'; 
ax.XAxis.FontName = 'FixedWidth'; 
ax.XAxis.FontSize = 10; 
xlabel('Time (days)',FontSize = 15)
