clear;
RGB = imread('Lenna.png');
YUV=RGB2YUV(RGB);
RGB_rec=YUV2RGB(YUV);

ImageAnalysis(RGB,RGB_rec);