# Swift5ImageProcessor


Coursera University of Toronto 
iOS App Development with Swift Specialization

Introduction to Swift Programming with Professor Parham Aarabi.
https://www.coursera.org/learn/swift-programming

Forum
https://www.coursera.org/learn/swift-programming/discussions/all/threads/WXe3-zcsS9G3t_s3LLvRoA

Original Week 4-5 source code was written for Swift 2.
This project encompasses the following activities.
- update project to Swift 5.1.
- demonstrate functionality with inclass sample code.
- implement my personal image processing filter.

## Update
ImageProcessor updated from XCode 7.3.1 (Swift 2) to XCode 11.5 (Swift 5.1). \
Edits and modification is primarily based on an existing article, project by Khalid Asad<sup>[1]</sup>. \
Updated version can be found at link.
https://github.com/yeuchi/Swift5ImageProcessor/blob/master/ImageProcessor.playground/Sources/RGBAImage.swift

## Sample Code Demo
Using in-class tutorial from Professor Parham Aarabi, below is the result of the redShift (75x75).
<img width="288" src="https://user-images.githubusercontent.com/1282659/83474607-010b1b00-a452-11ea-8f28-41546d8c9d37.png">

## Convolution Filter

Convolution with 5 popular - 3x3 kernels well described in Gonzolas & Woods' text<sup>[2]</sup>.  
Filter magnitude or effect level can be potentially be varied by the filter width (For example: 5x5, 7x7, etc).  
For this exercise which only requires 2 effects ('small' or 'large'), I am creating 2 versions of each filter (exclude Identity).

#### Identity (same)
<img width="358" alt="Screen Shot 2020-06-02 at 5 18 11 PM" src="https://user-images.githubusercontent.com/1282659/83575430-0f5e4300-a4f5-11ea-8152-a10bb75464f0.png">

#### Sharpen (laplacian + identity)
kernel (small effect): [[-1, -1, -1], [-1, 14, -1], [-1, -1, -1]] \
kernel (large effect): [[-1, -1, -1], [-1, 10, -1], [-1, -1, -1]] \
<img width="332" alt="Screen Shot 2020-06-02 at 4 16 38 PM" src="https://user-images.githubusercontent.com/1282659/83571020-a246af80-a4ec-11ea-9089-2c7772661a21.png">

#### Blur (Gaussian, RECT function)
kernel (small effect): [[1, 1, 1], [1, 5, 1], [1, 1, 1]] \
kernel (large effect): [[1, 1, 1], [1, 1, 1], [1, 1, 1]] \
<img width="358" alt="Screen Shot 2020-06-02 at 5 14 18 PM" src="https://user-images.githubusercontent.com/1282659/83575174-9101a100-a4f4-11ea-8524-e6ad7decd937.png">

#### Sobel (x, y)
kernel (small effect): [[0, 0, 0], [0, 1, -1], [0, 0, 0]] \
kernel (large effect): [[0, 1, -1], [0, 1, -1], [0, 1, -1]] \
kernel (small effect): [[0, 0, 0], [0, 1, 0], [0, -1, 0]] \
kernel (large effect): [[0, 0, 0], [1, 1, 1], [-1, -1, -1]] \
<img width="358" alt="xDerive" src="https://user-images.githubusercontent.com/1282659/83570191-3d3e8a00-a4eb-11ea-81bc-c2b1ddb1545b.png"><img width="347" alt="yDerive" src="https://user-images.githubusercontent.com/1282659/83570194-3f084d80-a4eb-11ea-9b92-87976417f9cf.png">

#### Arbitrary filter selection
Image processor looks N times to exhauset all available kernel types available in listKernel array. \
To define the type and order of operation, append a valid KernelType into the listKernel array. \
By default, there is an identify filter in the list.  Below are some examples.

var params = FilterParams() \
params.listKernel.append(KernelType.sharpen) \
params.listKernel.append(KernelType.blur) \
//params.listKernel.append(KernelType.xSobel) \
//params.listKernel.append(KernelType.ySoble) 

#### Effect level
Rubric requires that a 'small' or 'large' effect be available. \
Hence, I have implemented 2 types of kernel for each filter for easy selection. \
Otherwise, user is free to edit the kernel(s) directly. 

params.effectLevel = EffectLevel.large \
params.effectLevel = EffectLevel.small 


# Reference

1. How to Use UIkit for Low-Level Image Processing in Swift by Khalid Asad, 02/26/2020 \
https://blog.avenuecode.com/how-to-use-uikit-for-low-level-image-processing-in-swift

2. Digital Image Processing by Gonzalez and Woods, 1993. ISBN:0-201-50803-6
- Convolution pg 189 - 215
