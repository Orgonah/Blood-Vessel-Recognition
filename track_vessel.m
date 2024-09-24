function output = track_vessel(image_address,mask_address)
    image = imread(image_address);    
    mask = im2double(imread(mask_address));
    r = image(:,:,1);
    g = image(:,:,2);
    b = image(:,:,3);

    % Gradient
    [rmag, rdir] = imgradient(r,"sobel");
    [gmag, gdir] = imgradient(g,"sobel");
    [bmag, bdir] = imgradient(b,"sobel");
    
    % combine R G B and and make a logical image from threshold
    thresh = zeros(size(r));
    W = 131;
    rgbmag = (rmag+gmag+bmag);
    raw = rgbmag > thresh+W;

    % masking with a little bit less eye to remove the border
    SE = strel('disk',10);
    mask = imerode(mask,SE);
    raw = bitand(raw,mask);

    % fill empty spots
    R=3;
    SE = strel('disk',R);
    out = imclose(raw,SE);

    output = out;
end