function prepareLabeling( pth )

if nargin == 0,    pth = uigetdir( 'W:\2016_IJRR_Annotation' ); end

rgbfiles = dir( [ pth, '\RGB1*.png' ] );
rgbfiles = { rgbfiles.name };