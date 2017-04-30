%% DOCUMENT TITLE
% multi methods to read cdf
%%
file='/Users/yangjian/Desktop/c1 data/EFW/C1_CP_EFW_L2_P/C1_CP_EFW_L2_P__20010731_201417_20010731_201617_V110503.cdf';


%% matlab �Դ���cdfread

%   % Read all of the data from the file. Epoch16 can't be read
data = cdfread(file);    

%   % Read just the data from variable "Time".

data = cdfread(file, ...
    'Variables', {'Spacecraft_potential__C1_CP_EFW_L2_P'});


data=cdfread(file,'Structure',true);       %2014a

%% irf cdf read

info = spdfcdfinfo(file); % query metadata


irf_cdf_read %- interactively choose file and variable        %����cdf�����ļ���
% ======== Options ========
% q) quit, dont return anything
% v) list all variables
% vv) list all variables and their values
% r) read variable in default format
% t) read time variables in irfu format and return
% fa) list the file variable attributes
% fav) view the file variable attributes
% ga) list global attributes
% gav) view global attributes


irf_cdf_read('*.cdf','*'); %- allow to choose file and variables һ�㲻�ܷ���ʱ������

Spacecraft_potential=irf_cdf_read(file,'Spacecraft_potential__C1_CP_EFW_L2_P');


%% irf get data from different databases cdf
% database:  'omni2'    - 1h resolution OMNI2 data (default), see IRF_GET_DATA_OMNI
%            'omni_min' - 1min resolution OMNI data, see IRF_GET_DATA_OMNI
%            'caa' or 'csa' - Cluster Science Archive, see C_CAA_VAR_GET

B=irf_get_data('Spacecraft_potential__C1_CP_EFW_L2_P','caa');  %����structure

%��Ч���� C_CAA_VAR_GET ��ȡcaa         caa Ŀ¼ ���¼�Ŀ¼

varname='Spacecraft_potential__C1_CP_EFW_L2_P';
caa=c_caa_var_get(varname,'caa')  ;  %returns VariableStruct

%%  TSeries
caa=c_caa_var_get(varname,'ts')  ;  %returns TSeries object
caa=irf_get_data(varname,'caa','ts');


%% 
var=c_caa_var_get(varname,'mat')  ; %returns variableMat           ����ʱ������
var=irf_get_data(varname,'caa','mat');



%% DataObject

dobj=c_caa_var_get(varname,'dobj') ;%returns DataObject  �� data_obj����
unit=c_caa_var_get(varname,'unit') ;%returns only units




%% work with CAA data
%% 
Tsta='2001-07-31T20:15:17.499996Z';   
Tend='2001-07-31T20:16:17.499996Z';

tint=[iso2epoch(Tsta) iso2epoch(Tend)]; 

%    Construct dataobj form file FILENAME. FILENAME can also contain
%    wildcards ('*').
%����ѡ����Ҫʱ��ε�ʱ������ obj
data_obj=dataobj(file,'tint',tint);
vps=getmat(data_obj,'Spacecraft_potential__C1_CP_EFW_L2_P');




%% gui work with irf_caa caa �¼�Ŀ¼
irf_caa;     %

% ************************************************************************************
% ********** IRF CAA *********
% m) menu
% q) quit
% a) load all caa files in cdf format
% f) load files
% l) list loaded files
% c) choose from loaded files



