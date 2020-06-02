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
 * Description: My Insta Filter assignment - 3x3 spatial convolution filter
 * Author: Chi Yeung
 * Date: June 2, 2020
 */


/*
 * STEP 3: Create the image processor
 * a. Encapsulate your chosen Filter parameters and/or formulas in a struct/class definition.
 *
 * b. Create and test an ImageProcessor class/struct to manage an arbitrary number Filter instances to apply to an image. It should allow you to specify the order of application for the Filters.
 */
enum KernelType {
    case xSobel
    case ySobel
    case sharpen
    case blur
    case identity
}

/*
 * The formula should have parameters that can be modified so that the filter can have a small or large effect on the image.
 */
enum EffectLevel {
    case small
    case large
}

struct FilterParams {
    /*
     * Rubric:
     * Is there an interface to apply specific default filter formulas/parameters to an image, by specifying each configuration’s name as a String? Maximum of 2 pts
     *
     * Are there parameters for each filter formula that can change the intensity of the effect of the filter? Maximum of 3 pts
     */
    var listKernel:[KernelType] = [KernelType.identity]
    var effectLevel:EffectLevel = EffectLevel.small
    
    /*
     * STEP 4: Create predefined filters
     * - Create five reasonable default Filter configurations
     *
     * Define 3x3 kernels (could be different size 5x5, 7x7.. but too slow)
     * Sobel: derivatives
     * sharpen: laplacian + identity
     * blur: average
     *
     * Rubric:
     */
    private let identity: [[Int]] = [[0, 0, 0], [0, 1, 0], [0, 0, 0]]
    private let xSobel_small: [[Int]] = [[0, 0, 0], [0, 1, -1], [0, 0, 0]]
    private let xSobel_large: [[Int]] = [[0, 1, -1], [0, 1, -1], [0, 1, -1]]
    private let ySobel_small: [[Int]] = [[0, 0, 0], [0, 1, 0], [0, -1, 0]]
    private let ySobel_large: [[Int]] = [[0, 0, 0], [1, 1, 1], [-1, -1, -1]]
    private let sharpen_small: [[Int]] = [[-1, -1, -1], [-1, 14, -1], [-1, -1, -1]]
    private let sharpen_large: [[Int]] = [[-1, -1, -1], [-1, 10, -1], [-1, -1, -1]]
    private let blur_small: [[Int]] = [[1, 1, 1], [1, 5, 1], [1, 1, 1]]
    private let blur_large: [[Int]] = [[1, 1, 1], [1, 1, 1], [1, 1, 1]]
    
    func getKernel(type:KernelType) -> [[Int]] {
        switch(type) {
        case KernelType.xSobel:
            return effectLevel == EffectLevel.small ? xSobel_small : xSobel_large
            
        case KernelType.ySobel:
            return effectLevel == EffectLevel.small ? ySobel_small : ySobel_large
            
        case KernelType.sharpen:
            return effectLevel == EffectLevel.small ? sharpen_small : sharpen_large
            
        case KernelType.identity:
            return identity
            
        case KernelType.blur:
            return effectLevel == EffectLevel.small ? blur_small : blur_large
        }
    }
}

/*
 * STEP 5: Apply predefined filters
 * In the ImageProcessor interface create a new method to apply a predefined filter giving its name as a String parameter. The ImageProcessor interface should be able to look up the filter and apply it.
 *
 * !! User may add N filters in sequential processing !!
 *
 * Rubric:
 * Is there an interface to specify the order and parameters for an arbitrary number of filter calculations that should be applied to an image? Maximum of 2 pts
 */
var params = FilterParams()
params.effectLevel = EffectLevel.large
params.listKernel.append(KernelType.sharpen)
params.listKernel.append(KernelType.blur)
//params.listKernel.append(KernelType.xSobel)
//params.listKernel.append(KernelType.ySoble)



for k in 0..<params.listKernel.count {
    
    // iterate through all selected kernels
    let kernelType = params.listKernel[k]
    let filter = params.getKernel(type:kernelType)

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

    /*
     * Rubric:
     * Does the playground code apply a filter to each pixel of the image? Maximum of 2 pts
     */
    for y in 0..<myRGBA.height {
        for x in 0..<myRGBA.width {
            var sumRed = 0
            var sumGreen = 0
            var sumBlue = 0
            
            // integrate, convolve with kernel (index -1 -> 1)
            for cy in 0..<3 {
                for cx in 0..<3 {
                    
                    // constraint pixel index -> in bound
                    var yy = y + cy - 1
                    if(yy < 0){
                        yy = 0
                    }
                    else if (yy >= myRGBA.height) {
                        yy = myRGBA.height-1
                    }
                    
                    var xx = x + cx - 1
                    if(xx < 0){
                        xx = 0
                    }
                    else if (xx >= myRGBA.width) {
                        xx = myRGBA.width-1
                    }
                    
                    // do integration
                    let i = yy * myRGBA.width + xx
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
}
