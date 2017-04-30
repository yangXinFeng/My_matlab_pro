function [data_obj,x_data,y_data] = save_plot_data_from_figure( input_args )
%save_plot_data_from_figure �˴���ʾ�йش˺�����ժҪ
%������ͼ������
%   �˴���ʾ��ϸ˵��

data = get(get(gcf,'CurrentObject'));
x_data=data.XData;
y_data=data.YData;
data_obj=data;

%% 

flag_plot = irf_ask('Plot the data (1) or no plot(0)? [%]>',...
	'plot',0);
if flag_plot==1
figure('Name','New Plot Window','NumberTitle','off');
plot(x_data,y_data);
end
%% 
end

