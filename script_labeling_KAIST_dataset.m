function script_labeling_KAIST_dataset( bSelectRoot )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KAIST Multi-spectral Recognition Dataset
%                                Yukyung Choi et al. 2016.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% When the 'pngreadc.mexw64' makes a problem,
%   do followings:
%       >> clear mex; d = fileparts(which(mfilename));
%       >> delete( fullfile(d, videos, private, *png*) );
%
% - {rootPath} for KAIST dataset
%   - Set01 (AM05)
%       - V01 (North)
%           - T8 (Splitter)
%           - RGB1 (Splitter)       
%           - RGB2 (Stereo)     % Not used for labeling
%           - Velodyne           % Not used for labeling
%           - GPS-IMU           % Not used for labeling
%       - V02 (West)
%       - V03 (East)
%   - Set02
%   - Set03
%   - Set04
%   - Set05
%   - Set06
d = fileparts(which(mfilename));
addpath( genpath( d ) );

if nargin < 1, bSelectRoot = false; end

persistent rootPrv;
if bSelectRoot || isempty(rootPrv), pth = uigetdir( '.', 'Select rootPath' );        
else                                      pth = rootPrv;    
end   

if pth(1) == 0 || isempty(pth), error( 'Invalid rootPath.\n' ); return; end     %#ok<*UNRCH>

rootPrv = pth;

try
    for s = 1:6, 
        for v = 1:3, 
        seqName = sprintf('Set%02d\\V%02d', s, v );
        annName = sprintf('Set%02d_V%02d', s, v );
        if ~exist( [pth '/' seqName], 'dir' ), 
            warning( 'Cannot find %s. Skip this seq.\n', seqName );
            continue; 
        end    
        hFig = prepMultispectralLabeling( [pth '/' seqName], annName, false );
        uiwait( hFig );        
        end
    end
catch
    errordlg( sprintf('Fail to label %s\n', seqName) );
end

tmpFiles = dir( 'tmp*' );
for ii = 1:length(tmpFiles), delete( tmpFiles(ii).name ); end

end