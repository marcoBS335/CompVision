# CompVision
Shi-Tomasi Corner Detector - Computer Vision Assignement

# Overview (Slovak)
https://drive.google.com/file/d/1f_6t_V-rZZz2q8W3lZLELPyGGzMkxtp0/view?usp=sharing

# Pseudocode

```javascript
read image
convert image to grayscale
calculate derivates x and y axix orientation
calculate Shi-Tomasi metric 
calculate local maxima
if (pixel is local maxima and also satisfies metric){
  save pixel position
}
return pixel positions and its metric
```
