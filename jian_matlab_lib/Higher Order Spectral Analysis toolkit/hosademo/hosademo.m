function hosademo
%HOSADEMO Demonstrates some of the capabilities of the HOSA Toolbox
%	hosademo
%
%        HOSADEMO  presents a menu of demos.
%	 The HOSA Toolbox offers several routines for
%	 Signal Processing with Higher-Order Spectra
%	 The HOSA toolbox is a product of United Signals & Systems, Inc,
%	 and was developed by Ananthram Swami.


%        Copyright (c) 1991-2001 by United Signals & Systems, Inc. 
%       $Revision: 1.7 $
%        Author: A. Swami    April 15, 1993.


%     RESTRICTED RIGHTS LEGEND
% Use, duplication, or disclosure by the Government is subject to
% restrictions as set forth in subparagraph (c) (1) (ii) of the
% Rights in Technical Data and Computer Software clause of DFARS
% 252.227-7013.
% Manufacturer: United Signals & Systems, Inc., P.O. Box 2374,
% Culver City, California 90231.
%
%  This material may be reproduced by or for the U.S. Government pursuant
%  to the copyright license under the clause at DFARS 252.227-7013.

echo off, format compact

lab1 = str2mat( ...
     'Definitions - Quick Tutorial ', ...
     'Estimating Cumulants, Bispectra & Bicoherence ', ...
     'Gaussianity-Linearity Tests', ...
     'Linear Processes: Parametric System Identification ', ...
     'Linear Processes: Non-Parametric System Identification ', ...
     'Non-Linear Processes: Quadratic Phase Coupling ', ...
     'Identification of Second-Order Volterra Systems ');
lab2 = str2mat( ...
     'Harmonics in Noise: Parameter Estimation', ...
     'Time-Delay Estimation ', ...
     'Direction of Arrival Estimation (DOA) ', ...
     'Adaptive Parameter Estimation ' , ...
     'Time-Frequency Distributions ',  ...
     'Case studies ' ...
     );
labels = str2mat(lab1, lab2);

calls1 = str2mat( ...
     'demtut',        ...
     'dembisp',       ...
     'demgltst',      ...
     'demarma',       ...
     'demnpsi',       ...
     'demqpc',        ...
     'demvolt'      );
calls2 = str2mat( ...
     'demharm',       ...
     'demtde',        ...
     'demdoa',        ...
     'demadapt',      ...
     'demtfd',        ...
     'ex_case'        ...
      );

callbacks = str2mat(calls1, calls2);
%        name          header        buttons
interruptible = 1;
choices('HoSatDemo',  'HOSA Demo',   labels,  callbacks, interruptible);

clear
return

% Not directly demoed: cumest, cum2est, cum3est, cum4est,
%                      cum2x, cum3x, cum4x,  rpiid, ivcal, tls
%                      armaysn, doagen, nlgen, qpcgen, harmgen, tdegen
%                      hprony, trench
%       of course,  contents, readme, hostest, are extras.