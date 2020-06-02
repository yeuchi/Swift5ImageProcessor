//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")

// Process the image!
var myRGBA = RGBAImage(image:image!)!

let x=10
let y=10

let index = y * myRGBA.width + x
var pixel = myRGBA.pixels[index]

pixel.red
pixel.green
pixel.blue

// edit 1 pixel
pixel.red = 255
pixel.green = 0
pixel.blue = 0
myRGBA.pixels[index] = pixel

// find mean pixel value
var totalRed = 0
var totalGreen = 0
var totalBlue = 0

for y in 0..<myRGBA.height {
    for x in 0..<myRGBA.width {
        let i = y * myRGBA.width + x
        var pix = myRGBA.pixels[i]
    
        totalRed += Int(pix.red)
        totalGreen += Int(pix.green)
        totalBlue += Int(pix.blue)
    }
}

let count = myRGBA.width * myRGBA.height
let meanRed = totalRed / count
let meanGreen = totalGreen / count
let meanBlue = totalBlue / count
// mean: R=119, G=98, B=83

// Red highlight filter
for y in 0..<myRGBA.height {
    for x in 0..<myRGBA.width {
        let i = y * myRGBA.width + x
        var pix = myRGBA.pixels[i]
    
        let redDiff = Int(pix.red) - meanRed
        if(redDiff>0){
            pix.red = UInt8(max(0, min(255, meanRed+redDiff*5)))
            myRGBA.pixels[i] = pix
        }
    }
}
let newImage2 = myRGBA.toUIImage()

image

/*
 * My personal filter
 * 3x3 convolution
 */

// define kernels: derivatives, laplacian + identity = sharpen
let xSobel: [[Int]] = [[0, 0, 0], [0, 1, -1], [0, 0, 0]]
let ySobel: [[Int]] = [[0, 0, 0], [0, 1, 0], [0, -1, 0]]
let sharpen: [[Int]] = [[-1, -1, -1], [-1, 11, -1], [-1, -1, -1]]

/*
 * define which filter you want to use [xSobel, ySobel, sharpen] ?
 */
let filter = sharpen


// Denominator: find kernel sum
var denominator = 0
for cy in 0..<3 {
    for cx in 0..<3 {
        denominator += filter[cx][cy]
    }
}
if(denominator == 0) {
    denominator = 1
}
else if (denominator < 0) {
    denominator *= -1
}

// step through ALL pixels except boundary
for y in 1..<myRGBA.height-1 {
    for x in 1..<myRGBA.width-1 {
        var sumRed = 0
        var sumGreen = 0
        var sumBlue = 0
        
        // integrate, convolve with kernel (index -1 -> 1)
        for cy in 0..<3 {
            for cx in 0..<3 {
                let i = (y+(cy-1)) * myRGBA.width + (x+(cx-1))
                let pix = myRGBA.pixels[i]
                sumRed += Int(pix.red) * filter[cx][cy]
                sumGreen += Int(pix.green) * filter[cx][cy]
                sumBlue += Int(pix.blue) * filter[cx][cy]
            }
        }
        let ii = y * myRGBA.width + x
        myRGBA.pixels[ii].red = UInt8(max(0, min(255, sumRed/denominator)))
        myRGBA.pixels[ii].green = UInt8(max(0, min(255, sumGreen/denominator)))
        myRGBA.pixels[ii].blue = UInt8(max(0, min(255, sumBlue/denominator)))
    }
}
let convolvedImage = myRGBA.toUIImage()
newImage2

