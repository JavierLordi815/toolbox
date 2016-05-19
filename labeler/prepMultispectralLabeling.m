function hFig = prepMultispectralLabeling( srcDir, seqName, frVid, varargin )
srcDir( srcDir == '\' ) = '/';

ip = inputParser;
ip.addRequired('srcDir',                              @ischar);
ip.addRequired('seqName',                          @ischar);
ip.addRequired('frVid',                               @islogical);
ip.addParameter('vidTypes',       {'RGB1', 'T8'},    @iscell);
ip.addParameter('skip',               1,                  @isscalar);
ip.addParameter('fps',               20,                  @isscalar);

ip.parse(srcDir, seqName, frVid, varargin{:});
opts = ip.Results;

numSeq = length(opts.vidTypes);
if numSeq > 2, error( 'Too many sequences.' ); end
opts.vidTypes = cellfun( @(x) [ opts.srcDir '/' x ], opts.vidTypes, 'uniformoutput', false );
opts.seqName = [ opts.srcDir '/' opts.seqName ];

% Generate .seq file from avi or images
for ii = 1:numSeq,
    vName = opts.vidTypes{ii};
    if exist( [ vName '.seq' ], 'file' ), continue; end
           
    seqInfo.skip = opts.skip;
    seqInfo.nDigits = 9;
    seqInfo.f0 = 1;
    seqInfo.f1 = 10^10;

    if opts.frVid,
        seqInfo.aviName = [ vName '.avi' ];        
        if ~exist( seqInfo.aviName, 'file' ), error( 'Cannot read avi file.' ); end        
    else
        seqInfo.sDir = vName;
        files = dir( vName ); 
        [ ~, ~, ext ] = fileparts( files(3).name );
        info.codec = ext(2:end);
        im = imread( fullfile(vName, files(3).name) );
        [ info.height, info.width, ~ ] = size(im);
        info.fps = opts.fps;                  
    end       
    
    seqIo( vName, 'frImgs', info, seqInfo);
end
    
% Run Labeler
targetObjs = { 'person', 'car', 'people', 'ignore' };
occTypes = {'No-occ', 'Partial-occ', 'Heavy-occ'};
if numSeq == 1, vidTypes = opts.vidTypes([1 1]); 
else vidTypes = opts.vidTypes; end

hFig = vbbLabeler2( targetObjs, occTypes, vidTypes, opts.seqName );
