function script_labeling_KAIST_dataset( pth, setNum, vidNum )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KAIST Multi-spectral Recognition Dataset
%                                Yukyung Choi et al. 2016.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% When the 'pngreadc.mexw64' makes a problem,
%   please do followings:
%       >> clear mex; d = fileparts(which(mfilename));
%       >> delete( fullfile(d, videos, private, *png*) );
%
% - {rootPath} for KAIST dataset
%   - Set01 (AM05)
%       - V01 (North)
%           - T8 (Splitter)
%           - RGB (Splitter)       
%       - V02 (West)
%       - V03 (East)
%   - Set02
%   - Set03
%   - Set04
%   - Set05
%   - Set06

if nargin < 3, return; end
if ~exist( pth, 'dir' ), pth = uigetdir; end
if pth == 0, return; end

name = sprintf( '%s/Set%02d/V%03d/', pth, setNum, vidNum );

targetObjs = { 'person', 'car', 'people', 'ignore' };
occTypes = {'No-occ', 'Partial-occ', 'Heavy-occ'};
seqNames = { [ name 'RGB.seq' ], [ name 'T8.seq' ] };

hFig = vbbLabeler2( targetObjs, occTypes, seqNames );
uiwait( hFig );

tmpFiles = dir( 'tmp*' );
arrayfun( @(x) delete( x.name ), tmpFiles, 'uniformoutput', false );

