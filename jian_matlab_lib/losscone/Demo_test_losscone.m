%% init
addpath('../losscone')
% mkdir('Test_Matlab_Export_fig');
% cd Test_Matlab_Export_fig

%% 2D lat/lon plot of Earth's magnetic field strength at given altitude.
% Also plots direction in quiver plot.
% �����߶ȴų�����ʹ�С  IGRF ģ��
BfieldMap;

%% 2D lat/lon plot of Earth's magnetic field strength at given altitude.
%�ų����� ����loss cone angleʱ��ϳ�
BfieldTLEerror;
BfieldTLEerror_iter;

%% ��Ӧ����γ�ȵĴ�γ��
%���� getmaglat
geomaglatitute;

%% testing Jack's calculations for solid angles

JackGF;

%% ��Ӧ����γ�ȸ���ʱ��߶ȶ�Ӧ�� L shell
% L-shell for Altitude 100 km: 31-Aug-2012

myLshellmap;


%% Plot the Earth's magnetic field lines using the IGRF.
plotbearth;
plotbline;

%% Loss Cone Pitch Angle ������Ҫ 8h
% ���� Output750_02.mat


testlosscone








