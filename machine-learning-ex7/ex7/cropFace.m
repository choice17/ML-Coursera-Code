function cImg = cropFace(img)
i = img;
faceDetector = vision.CascadeObjectDetector();
bbox            = step(faceDetector, i);
cImg = [];
if size(bbox,2)==4
% Draw the returned bounding box around the detected face.
cImg = imcrop(i,bbox);
end
end