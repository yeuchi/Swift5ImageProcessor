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
 * 
 */
