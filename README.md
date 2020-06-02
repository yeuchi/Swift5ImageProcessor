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
ImageProcessor updated from XCode 7.3.1 (Swift 2) to XCode 11.5 (Swift 5.1).\
Edits and modification is primarily based on an existing article, project by Khalid Asad<sup>[1]</sup>.\
Updated version can be found at link.
https://github.com/yeuchi/Swift5ImageProcessor/blob/master/ImageProcessor.playground/Sources/RGBAImage.swift

## Sample Code Demo
Using in-class tutorial from Professor Parham Aarabi, below is the result of the redShift (75x75).
<img width="288" src="https://user-images.githubusercontent.com/1282659/83474607-010b1b00-a452-11ea-8f28-41546d8c9d37.png">

## Implement Filter

Implementation of kernenls and convolution is well described in Gonzolas & Woods' book[3]. Below filters have been implemented.

3x3 sharpen
<img width="318" alt="sharpen" src="https://user-images.githubusercontent.com/1282659/83570186-3b74c680-a4eb-11ea-8d0e-2e32cd0a3c20.png">

Sobel (x, y)
<img width="358" alt="xDerive" src="https://user-images.githubusercontent.com/1282659/83570191-3d3e8a00-a4eb-11ea-81bc-c2b1ddb1545b.png">
<img width="347" alt="yDerive" src="https://user-images.githubusercontent.com/1282659/83570194-3f084d80-a4eb-11ea-9b92-87976417f9cf.png">


# Reference

1. How to Use UIkit for Low-Level Image Processing in Swift by Khalid Asad, 02/26/2020
https://blog.avenuecode.com/how-to-use-uikit-for-low-level-image-processing-in-swift
