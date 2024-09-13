# Core Image Filters
### iOS 12.2 has 207 filters.



## Accordion Fold Transition (CIAccordionFoldTransition)
###### First available: iOS 8

Transitions from one image to another of a differing dimensions by unfolding.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Bottom Height (NSNumber - Distance) – No description available.
* Number of Folds (NSNumber - Scalar) – No description available.
* Fold Shadow Amount (NSNumber - Scalar) – No description available.
* Time (NSNumber - Time) – The duration of the effect.

#### Outputs
* Image



## Addition (CIAdditionCompositing)
###### First available: iOS 5

Adds color components to achieve a brightening effect. This filter is typically used to add highlights and lens flare effects.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Affine Clamp (CIAffineClamp)
###### First available: iOS 6

Performs an affine transform on a source image and then clamps the pixels at the edge of the transformed image, extending them outwards. This filter performs similarly to the “Affine Transform” filter except that it produces an image with infinite extent. You can use this filter when you need to blur an image but you want to avoid a soft, black fringe along the edges.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Transform (NSAffineTransform) – The transform to apply to the image.

#### Outputs
* Image



## Affine Tile (CIAffineTile)
###### First available: iOS 6

Applies an affine transform to an image and then tiles the transformed image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Transform (NSAffineTransform) – The transform to apply to the image.

#### Outputs
* Image



## Affine Transform (CIAffineTransform)
###### First available: iOS 5

Applies an affine transform to an image. You can scale, translate, or rotate the input image. You can also apply a combination of these operations.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Transform (NSAffineTransform - Transform) – A transform to apply to the image.

#### Outputs
* Image



## Area Average (CIAreaAverage)
###### First available: iOS 9

Calculates the average color for the specified area in an image, returning the result in a pixel.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image
* ImageMPS
* ImageNonMPS



## Area Histogram (CIAreaHistogram)
###### First available: iOS 8

Calculates histograms of the R, G, B, and A channels of the specified area of an image. The output image is a one pixel tall image containing the histogram data for all four channels.

#### Inputs
* Image (CIImage - Image) – The image whose histogram you want to calculate.
* Extent (CIVector - Rectangle) – A rectangle that, after intersection with the image extent, specifies the subregion of the image that you want to process.
* Scale (NSNumber - Scalar) – The scale value to use for the histogram values. If the scale is 1.0, then the bins in the resulting image will add up to 1.0.
* Count (NSNumber - Scalar) – The number of bins for the histogram. This value will determine the width of the output image.

#### Outputs
* Image
* ImageMPS
* ImageNonMPS
* Data



## Area Maximum (CIAreaMaximum)
###### First available: iOS 9

Calculates the maximum component values for the specified area in an image, returning the result in a pixel.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Area Maximum Alpha (CIAreaMaximumAlpha)
###### First available: iOS 9

Finds and returns the pixel with the maximum alpha value.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Area Min and Max (CIAreaMinMax)
###### First available: iOS 12

Calculates the per-component minimum and maximum value for the specified area in an image. The result is returned in a 2x1 image where the component minimum values are stored in the pixel on the left.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image
* ImageMPS
* ImageNonMPS



## Area Min and Max Red (CIAreaMinMaxRed)
###### First available: iOS 11

Calculates the minimum and maximum red component value for the specified area in an image. The result is returned in the red and green channels of a one pixel image.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Area Minimum (CIAreaMinimum)
###### First available: iOS 9

Calculates the minimum component values for the specified area in an image, returning the result in a pixel.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Area Minimum Alpha (CIAreaMinimumAlpha)
###### First available: iOS 9

Finds and returns the pixel with the minimum alpha value.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Attributed Text Image Generator (CIAttributedTextImageGenerator)
###### First available: iOS 11

Generate an image attributed string.

#### Inputs
* Text (NSAttributedString) – No description available.
* Scale Factor (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Aztec Code Generator (CIAztecCodeGenerator)
###### First available: iOS 8

Generate an Aztec barcode image for message data.

#### Inputs
* Message (NSData) – The message to encode in the Aztec Barcode
* Correction Level (NSNumber) – Aztec error correction value between 5 and 95
* Layers (NSNumber) – Aztec layers value between 1 and 32. Set to nil for automatic.
* Compact Style (NSNumber) – Force a compact style Aztec code to @YES or @NO. Set to nil for automatic.

#### Outputs
* Image
* CGImage



## Barcode Generator (CIBarcodeGenerator)
###### First available: iOS 11

Generate a barcode image from a CIBarcodeDescriptor.

#### Inputs
* Barcode Descriptor (CIBarcodeDescriptor) – The CIBarcodeDescription object to generate an image for.

#### Outputs
* CGImageForQRCodeDescriptor
* CGImage
* CGImageForAztecCodeDescriptor
* CGImageForPDF417CodeDescriptor
* CGImageForDataMatrixCodeDescriptor
* Image



## Bars Swipe Transition (CIBarsSwipeTransition)
###### First available: iOS 6

Transitions from one image to another by swiping rectangular portions of the foreground image to disclose the target image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Angle (NSNumber - Angle) – The angle (in radians) of the bars.
* Width (NSNumber - Distance) – The width of each bar.
* Bar Offset (NSNumber - Scalar) – The offset of one bar with respect to another
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).

#### Outputs
* Image



## Bicubic Scale Transform (CIBicubicScaleTransform)
###### First available: iOS 11

Produces a high-quality, scaled version of a source image. The parameters of B and C for this filter determine the sharpness or softness of the resampling. The most commonly used B and C values are 0.0 and 0.75, respectively.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Scale (NSNumber - Scalar) – The scaling factor to use on the image. Values less than 1.0 scale down the images. Values greater than 1.0 scale up the image.
* Aspect Ratio (NSNumber - Scalar) – The additional horizontal scaling factor to use on the image.
* B (NSNumber - Scalar) – Specifies the value of B to use for the cubic resampling function.
* C (NSNumber - Scalar) – Specifies the value of C to use for the cubic resampling function.

#### Outputs
* Image



## Blend With Alpha Mask (CIBlendWithAlphaMask)
###### First available: iOS 7

Uses values from a grayscale mask to interpolate between an image and the background. When a mask alpha value is 0.0, the result is the background. When the mask alpha value is 1.0, the result is the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.
* Mask Image (CIImage - Image) – A masking image.

#### Outputs
* Image



## Blend With Blue Mask (CIBlendWithBlueMask)
###### First available: iOS 11

Uses values from a mask image to interpolate between an image and the background. When a mask blue value is 0.0, the result is the background. When the mask blue value is 1.0, the result is the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.
* Mask Image (CIImage - Image) – A masking image.

#### Outputs
* Image



## Blend With Mask (CIBlendWithMask)
###### First available: iOS 6

Uses values from a grayscale mask to interpolate between an image and the background. When a mask green value is 0.0, the result is the background. When the mask green value is 1.0, the result is the image.

#### Inputs
* Image (CIImage - Image) – The image to use as a foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.
* Mask Image (CIImage - Image) – A grayscale mask. When a mask value is 0.0, the result is the background. When the mask value is 1.0, the result is the image.

#### Outputs
* Image



## Blend With Red Mask (CIBlendWithRedMask)
###### First available: iOS 11

Uses values from a mask image to interpolate between an image and the background. When a mask red value is 0.0, the result is the background. When the mask red value is 1.0, the result is the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.
* Mask Image (CIImage - Image) – A masking image.

#### Outputs
* Image



## Bloom (CIBloom)
###### First available: iOS 6

Softens edges and applies a pleasant glow to an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the effect. The larger the radius, the greater the effect.
* Intensity (NSNumber - Scalar) – The intensity of the effect. A value of 0.0 is no effect. A value of 1.0 is the maximum effect.

#### Outputs
* Image



## Bokeh Blur (CIBokehBlur)
###### First available: iOS 11

Smooths an image using a disc-shaped convolution kernel.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
* Ring Amount (NSNumber - Scalar) – The amount of extra emphasis at the ring of the bokeh.
* Ring Size (NSNumber - Scalar) – The size of extra emphasis at the ring of the bokeh
* Softness (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Box Blur (CIBoxBlur)
###### First available: iOS 9

Smooths or sharpens an image using a box-shaped convolution kernel.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.

#### Outputs
* Image



## Bump Distortion (CIBumpDistortion)
###### First available: iOS 6

Creates a concave or convex bump that originates at a specified point in the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Scale (NSNumber - Scalar) – The scale of the effect determines the curvature of the bump. A value of 0.0 has no effect. Positive values create an outward bump; negative values create an inward bump.

#### Outputs
* Image



## Bump Distortion Linear (CIBumpDistortionLinear)
###### First available: iOS 6

Creates a bump that originates from a linear portion of the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Angle (NSNumber - Angle) – The angle (in radians) of the line around which the distortion occurs.
* Scale (NSNumber - Scalar) – The scale of the effect.

#### Outputs
* Image



## CMYK Halftone (CICMYKHalftone)
###### First available: iOS 9

Creates a color, halftoned rendition of the source image, using cyan, magenta, yellow, and black inks over a white page.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the halftone pattern
* Width (NSNumber - Distance) – The distance between dots in the pattern.
* Angle (NSNumber - Angle) – The angle of the pattern.
* Sharpness (NSNumber - Distance) – The sharpness of the pattern. The larger the value, the sharper the pattern.
* Gray Component Replacement (NSNumber - Scalar) – The gray component replacement value. The value can vary from 0.0 (none) to 1.0.
* Under Color Removal (NSNumber - Scalar) – The under color removal value. The value can vary from 0.0 to 1.0. 

#### Outputs
* Image



## Lens Correction for AVC (CICameraCalibrationLensCorrection)
###### First available: iOS 12

Geometrically distorts an image by altering the magnification based on the radial distance from the optical center to the farthest radius.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Calibration Data object of type AVCameraCalibrationData (AVCameraCalibrationData) – AVCameraCalibrationData for the correction.  Will be set from the inputImage if available and can be overridden here.
* Use Inverse Look Up Table (NSNumber) – Boolean value used to select the Look Up Table from the AVCameraCalibrationData

#### Outputs
* Image



## Checkerboard (CICheckerboardGenerator)
###### First available: iOS 5

Generates a pattern of squares of alternating colors. You can specify the size, colors, and the sharpness of the pattern.

#### Inputs
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Color 1 (CIColor) – A color to use for the first set of squares.
* Color 2 (CIColor) – A color to use for the second set of squares.
* Width (NSNumber - Distance) – The width of the squares in the pattern.
* Sharpness (NSNumber - Scalar) – The sharpness of the edges in pattern. The smaller the value, the more blurry the pattern. Values range from 0.0 to 1.0.

#### Outputs
* Image



## Circle Splash Distortion (CICircleSplashDistortion)
###### First available: iOS 6

Distorts the pixels starting at the circumference of a circle and emanating outward.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.

#### Outputs
* Image



## Circular Screen (CICircularScreen)
###### First available: iOS 6

Simulates a circular-shaped halftone screen.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the circular screen pattern
* Width (NSNumber - Distance) – The distance between each circle in the pattern.
* Sharpness (NSNumber - Scalar) – The sharpness of the circles. The larger the value, the sharper the circles.

#### Outputs
* Image



## Circular Wrap Distortion (CICircularWrap)
###### First available: iOS 9

Wraps an image around a transparent circle. The distortion of the image increases with the distance from the center of the circle.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Angle (NSNumber - Angle) – The angle of the effect.

#### Outputs
* Image



## Clamp (CIClamp)
###### First available: iOS 10

Clamps an image so the pixels with the specified extent are left unchanged but those at the boundary of the extent are extended outwards. This filter produces an image with infinite extent. You can use this filter when you need to blur an image but you want to avoid a soft, black fringe along the edges.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Extent (CIVector - Rectangle) – A rectangle that defines the extent of the effect.

#### Outputs
* Image



## Code 128 Barcode Generator (CICode128BarcodeGenerator)
###### First available: iOS 8

Generate a Code 128 barcode image for message data.

#### Inputs
* Message (NSData) – The message to encode in the Code 128 Barcode
* Quiet Space (NSNumber - Scalar) – The number of empty white pixels that should surround the barcode.
* Barcode Height (NSNumber - Scalar) – The height of the generated barcode in pixels.

#### Outputs
* Image
* CGImage



## Color Blend Mode (CIColorBlendMode)
###### First available: iOS 5

Uses the luminance values of the background with the hue and saturation values of the source image. This mode preserves the gray levels in the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Color Burn Blend Mode (CIColorBurnBlendMode)
###### First available: iOS 5

Darkens the background image samples to reflect the source image samples. Source image sample values that specify white do not produce a change.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Color Clamp (CIColorClamp)
###### First available: iOS 7

Clamp color to a certain range.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Min Components (CIVector) – Lower clamping values
* Max Components (CIVector) – Higher clamping values

#### Outputs
* Image



## Color Controls (CIColorControls)
###### First available: iOS 5

Adjusts saturation, brightness, and contrast values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Saturation (NSNumber - Scalar) – The amount of saturation to apply. The larger the value, the more saturated the result.
* Brightness (NSNumber - Scalar) – The amount of brightness to apply. The larger the value, the brighter the result.
* Contrast (NSNumber - Scalar) – The amount of contrast to apply. The larger the value, the more contrast in the resulting image.

#### Outputs
* Image



## Color Cross Polynomial (CIColorCrossPolynomial)
###### First available: iOS 7

Adjusts the color of an image with polynomials.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Red Coefficients (CIVector) – Polynomial coefficients for red channel
* Green Coefficients (CIVector) – Polynomial coefficients for green channel
* Blue Coefficients (CIVector) – Polynomial coefficients for blue channel

#### Outputs
* Image



## Color Cube (CIColorCube)
###### First available: iOS 5

Uses a three-dimensional color table to transform the source image pixels.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Cube Dimension (NSNumber - Count) – No description available.
* Cube Data (NSData) – Data containing a 3-dimensional color table of floating-point premultiplied RGBA values. The cells are organized in a standard ordering. The columns and rows of the data are indexed by red and green, respectively. Each data plane is followed by the next higher plane in the data, with planes indexed by blue.

#### Outputs
* Image



## Color Cube with ColorSpace (CIColorCubeWithColorSpace)
###### First available: iOS 7

Uses a three-dimensional color table in a specified colorspace to transform the source image pixels.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Cube Dimension (NSNumber - Count) – No description available.
* Cube Data (NSData) – Data containing a 3-dimensional color table of floating-point premultiplied RGBA values. The cells are organized in a standard ordering. The columns and rows of the data are indexed by red and green, respectively. Each data plane is followed by the next higher plane in the data, with planes indexed by blue.
* Color Space (NSObject) – No description available.

#### Outputs
* Image



## Color Cubes Mixed With Mask (CIColorCubesMixedWithMask)
###### First available: iOS 11

Uses two three-dimensional color tables in a specified colorspace to transform the source image pixels. The mask image is used as an interpolant to mix the output of the two cubes.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Mask Image (CIImage - Image) – A masking image.
* Cube Dimension (NSNumber - Count) – No description available.
* Cube 0 Data (NSData) – Data containing a 3-dimensional color table of floating-point premultiplied RGBA values. The cells are organized in a standard ordering. The columns and rows of the data are indexed by red and green, respectively. Each data plane is followed by the next higher plane in the data, with planes indexed by blue.
* Cube 1 Data (NSData) – Data containing a 3-dimensional color table of floating-point premultiplied RGBA values. The cells are organized in a standard ordering. The columns and rows of the data are indexed by red and green, respectively. Each data plane is followed by the next higher plane in the data, with planes indexed by blue.
* Color Space (NSObject) – No description available.

#### Outputs
* Image



## Color Curves (CIColorCurves)
###### First available: iOS 11

Uses a three-channel one-dimensional color table to transform the source image pixels. The color table must be composed of floating-point RGB values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Curves Data (NSData) – No description available.
* Curves Domain (CIVector) – No description available.
* Color Space (NSObject) – No description available.

#### Outputs
* Image



## Color Dodge Blend Mode (CIColorDodgeBlendMode)
###### First available: iOS 5

Brightens the background image samples to reflect the source image samples. Source image sample values that specify black do not produce a change.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Color Invert (CIColorInvert)
###### First available: iOS 5

Inverts the colors in an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Color Map (CIColorMap)
###### First available: iOS 6

Performs a nonlinear transformation of source color values using mapping values provided in a table.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Gradient Image (CIImage - Gradient) – The image data from this image transforms the source image values.

#### Outputs
* Image



## Color Matrix (CIColorMatrix)
###### First available: iOS 5

Multiplies source color values and adds a bias factor to each color component.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Red Vector (CIVector) – The amount of red to multiply the source color values by.
* Green Vector (CIVector) – The amount of green to multiply the source color values by.
* Blue Vector (CIVector) – The amount of blue to multiply the source color values by.
* Alpha Vector (CIVector) – The amount of alpha to multiply the source color values by.
* Bias Vector (CIVector) – A vector that’s added to each color component.

#### Outputs
* Image



## Color Monochrome (CIColorMonochrome)
###### First available: iOS 5

Remaps colors so they fall within shades of a single color.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Color (CIColor - OpaqueColor) – The monochrome color to apply to the image.
* Intensity (NSNumber - Scalar) – The intensity of the monochrome effect. A value of 1.0 creates a monochrome image using the supplied color. A value of 0.0 has no effect on the image.

#### Outputs
* Image



## Color Polynomial (CIColorPolynomial)
###### First available: iOS 7

Adjusts the color of an image with polynomials.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Red Coefficients (CIVector) – Polynomial coefficients for red channel
* Green Coefficients (CIVector) – Polynomial coefficients for green channel
* Blue Coefficients (CIVector) – Polynomial coefficients for blue channel
* Alpha Coefficients (CIVector) – Polynomial coefficients for alpha channel

#### Outputs
* Image



## Color Posterize (CIColorPosterize)
###### First available: iOS 6

Remaps red, green, and blue color components to the number of brightness values you specify for each color component. This filter flattens colors to achieve a look similar to that of a silk-screened poster.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Levels (NSNumber - Scalar) – The number of brightness levels to use for each color component. Lower values result in a more extreme poster effect.

#### Outputs
* Image



## Column Average (CIColumnAverage)
###### First available: iOS 9

Calculates the average color for each column of the specified area in an image, returning the result in a 1D image.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## Comic Effect (CIComicEffect)
###### First available: iOS 9

Simulates a comic book drawing by outlining edges and applying a color halftone effect.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Constant Color (CIConstantColorGenerator)
###### First available: iOS 5

Generates a solid color. You typically use the output of this filter as the input to another filter.

#### Inputs
* Color (CIColor - Color) – The color to generate.

#### Outputs
* Image



## 3 by 3 convolution (CIConvolution3X3)
###### First available: iOS 7

Convolution with 3 by 3 matrix

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Weights (CIVector) – No description available.
* Bias (NSNumber) – No description available.

#### Outputs
* Image



## 5 by 5 convolution (CIConvolution5X5)
###### First available: iOS 7

Convolution with 5 by 5 matrix

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Weights (CIVector) – No description available.
* Bias (NSNumber) – No description available.

#### Outputs
* Image



## 7 by 7 convolution (CIConvolution7X7)
###### First available: iOS 9

Convolution with 7 by 7 matrix

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Weights (CIVector) – No description available.
* Bias (NSNumber) – No description available.

#### Outputs
* Image



## Horizontal 9 Convolution (CIConvolution9Horizontal)
###### First available: iOS 7

Horizontal Convolution with 9 values

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Weights (CIVector) – No description available.
* Bias (NSNumber) – No description available.

#### Outputs
* Image



## Vertical 9 Convolution (CIConvolution9Vertical)
###### First available: iOS 7

Vertical Convolution with 9 values

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Weights (CIVector) – No description available.
* Bias (NSNumber) – No description available.

#### Outputs
* Image



## Copy Machine (CICopyMachineTransition)
###### First available: iOS 6

Transitions from one image to another by simulating the effect of a copy machine.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Extent (CIVector - Rectangle) – A rectangle that defines the extent of the effect.
* Color (CIColor - OpaqueColor) – The color of the copier light.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Angle (NSNumber - Angle) – The angle of the copier light.
* Width (NSNumber - Distance) – The width of the copier light. 
* Opacity (NSNumber - Scalar) – The opacity of the copier light. A value of 0.0 is transparent. A value of 1.0 is opaque.

#### Outputs
* Image



## CoreML Model Filter (CICoreMLModelFilter)
###### First available: iOS 12

Generates output image by applying input CoreML model to the input image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Model (MLModel) – The CoreML model to be used for applying effect on the image.

#### Outputs
* Image



## Crop (CICrop)
###### First available: iOS 5

Applies a crop to an image. The size and shape of the cropped image depend on the rectangle you specify.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Rectangle (CIVector - Rectangle) – The rectangle that specifies the crop to apply to the image.

#### Outputs
* Image



## Crystallize (CICrystallize)
###### First available: iOS 9

Creates polygon-shaped color blocks by aggregating source pixel-color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the effect. The larger the radius, the larger the resulting crystals.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.

#### Outputs
* Image



## Darken Blend Mode (CIDarkenBlendMode)
###### First available: iOS 5

Creates composite image samples by choosing the darker samples (from either the source image or the background). The result is that the background image samples are replaced by any source image samples that are darker. Otherwise, the background image samples are left unchanged.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Depth Blur Effect (CIDepthBlurEffect)
###### First available: iOS 11

Applies a variable radius disc blur to an image where areas in the background are softened more than those in the foreground.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Disparity Image (CIImage) – No description available.
* Matte Image (CIImage) – A matting image.
* Aperture (NSNumber - Scalar) – No description available.
* Left Eye Positions (CIVector - Position) – No description available.
* Right Eye Positions (CIVector - Position) – No description available.
* Chin Positions (CIVector - Position) – No description available.
* Nose Positions (CIVector - Position) – No description available.
* Focus Rectangle (CIVector - Rectangle) – No description available.
* Luma Noise Scale (NSNumber - Scalar) – No description available.
* Scale Factor (NSNumber - Scalar) – No description available.
* Calibration Data (AVCameraCalibrationData) – No description available.
* Aux Data Metadata (CGImageMetadataRef) – No description available.
* Shape (NSString) – No description available.

#### Outputs
* Image



## Depth of Field (CIDepthOfField)
###### First available: iOS 9

Simulates miniaturization effect created by Tilt & Shift lens by performing depth of field effects.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Point 0 (CIVector - Position) – No description available.
* Point 1 (CIVector - Position) – No description available.
* Saturation (NSNumber - Scalar) – The amount to adjust the saturation.
* Unsharp Mask Radius (NSNumber - Scalar) – No description available.
* Unsharp Mask Intensity (NSNumber - Scalar) – No description available.
* Radius (NSNumber - Scalar) – The distance from the center of the effect.

#### Outputs
* Image



## Depth To Disparity (CIDepthToDisparity)
###### First available: iOS 11

Convert a depth data image to disparity data.

#### Inputs
* Image (CIImage - Image) – The input depth data image to convert to disparity data.

#### Outputs
* Image



## Difference Blend Mode (CIDifferenceBlendMode)
###### First available: iOS 5

Subtracts either the source image sample color from the background image sample color, or the reverse, depending on which sample has the greater brightness value. Source image sample values that are black produce no change; white inverts the background color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Disc Blur (CIDiscBlur)
###### First available: iOS 9

Smooths an image using a disc-shaped convolution kernel.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.

#### Outputs
* Image



## Disintegrate With Mask (CIDisintegrateWithMaskTransition)
###### First available: iOS 6

Transitions from one image to another using the shape defined by a mask.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Mask Image (CIImage - Image) – An image that defines the shape to use when disintegrating from the source to the target image.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Shadow Radius (NSNumber - Distance) – The radius of the shadow created by the mask.
* Shadow Density (NSNumber - Scalar) – The density of the shadow created by the mask.
* Shadow Offset (CIVector - Offset) – The offset of the shadow created by the mask.

#### Outputs
* Image



## Disparity To Depth (CIDisparityToDepth)
###### First available: iOS 11

Convert a disparity data image to depth data.

#### Inputs
* Image (CIImage - Image) – The input disparity data image to convert to depth data.

#### Outputs
* Image



## Displacement Distortion (CIDisplacementDistortion)
###### First available: iOS 9

Applies the grayscale values of the second image to the first image. The output image has a texture defined by the grayscale values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Displacement Image (CIImage) – An image whose grayscale values will be applied to the source image.
* Scale (NSNumber - Distance) – The amount of texturing of the resulting image. The larger the value, the greater the texturing.

#### Outputs
* Image



## Dissolve (CIDissolveTransition)
###### First available: iOS 6

Uses a dissolve to transition from one image to another.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).

#### Outputs
* Image



## Dither (CIDither)
###### First available: iOS 12

Apply dithering to an image. This operation is usually performed in a perceptual color space.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Intensity (NSNumber - Scalar) – The intensity of the effect.

#### Outputs
* Image



## Divide Blend Mode (CIDivideBlendMode)
###### First available: iOS 8

Divides the background image sample color from the source image sample color.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Dot Screen (CIDotScreen)
###### First available: iOS 6

Simulates the dot patterns of a halftone screen.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the dot screen pattern
* Angle (NSNumber - Angle) – The angle of the pattern.
* Width (NSNumber - Distance) – The distance between dots in the pattern.
* Sharpness (NSNumber - Scalar) – The sharpness of the pattern. The larger the value, the sharper the pattern.

#### Outputs
* Image



## Droste (CIDroste)
###### First available: iOS 9

Performs M.C. Escher Droste style deformation

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Inset Point 0 (CIVector - Position) – No description available.
* Inset Point 1 (CIVector - Position) – No description available.
* Strands (NSNumber - Scalar) – No description available.
* Periodicity (NSNumber - Scalar) – No description available.
* Rotation (NSNumber - Angle) – No description available.
* Zoom (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Edge Preserve Upsample Filter (CIEdgePreserveUpsampleFilter)
###### First available: iOS 10

Upsamples a small image to the size of the input image using the luminance of the input image as a guide to preserve detail.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Small Image (CIImage) – No description available.
* Spatial Sigma (NSNumber - Scalar) – No description available.
* Luma Sigma (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Edge Work (CIEdgeWork)
###### First available: iOS 9

Produces a stylized black-and-white rendition of an image that looks similar to a woodblock cutout.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The thickness of the edges. The larger the value, the thicker the edges.

#### Outputs
* Image



## Edges (CIEdges)
###### First available: iOS 9

Finds all edges in an image and displays them in color.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Intensity (NSNumber - Scalar) – The intensity of the edges. The larger the value, the higher the intensity.

#### Outputs
* Image



## Eightfold Reflected Tile (CIEightfoldReflectedTile)
###### First available: iOS 6

Produces a tiled image from a source image by applying an 8-way reflected symmetry.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Exclusion Blend Mode (CIExclusionBlendMode)
###### First available: iOS 5

Produces an effect similar to that produced by the “Difference Blend Mode” filter but with lower contrast. Source image sample values that are black do not produce a change; white inverts the background color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Exposure Adjust (CIExposureAdjust)
###### First available: iOS 5

Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* EV (NSNumber - Scalar) – The amount to adjust the exposure of the image by. The larger the value, the brighter the exposure.

#### Outputs
* Image



## False Color (CIFalseColor)
###### First available: iOS 5

Maps luminance to a color ramp of two colors. False color is often used to process astronomical and other scientific data, such as ultraviolet and x-ray images.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Color 1 (CIColor - Color) – The first color to use for the color ramp.
* Color 2 (CIColor - Color) – The second color to use for the color ramp.

#### Outputs
* Image



## Flash (CIFlashTransition)
###### First available: iOS 6

Transitions from one image to another by creating a flash. The flash originates from a point you specify. Small at first, it rapidly expands until the image frame is completely filled with the flash color. As the color fades, the target image begins to appear.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Extent (CIVector - Rectangle) – The extent of the flash.
* Color (CIColor - Color) – The color of the light rays emanating from the flash.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Maximum Striation Radius (NSNumber - Scalar) – The radius of the light rays emanating from the flash.
* Striation Strength (NSNumber - Scalar) – The strength of the light rays emanating from the flash.
* Striation Contrast (NSNumber - Scalar) – The contrast of the light rays emanating from the flash.
* Fade Threshold (NSNumber - Scalar) – The amount of fade between the flash and the target image. The higher the value, the more flash time and the less fade time.

#### Outputs
* Image



## Fourfold Reflected Tile (CIFourfoldReflectedTile)
###### First available: iOS 6

Produces a tiled image from a source image by applying a 4-way reflected symmetry.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.
* Acute Angle (NSNumber - Angle) – The primary angle for the repeating reflected tile. Small values create thin diamond tiles, and higher values create fatter reflected tiles.

#### Outputs
* Image



## Fourfold Rotated Tile (CIFourfoldRotatedTile)
###### First available: iOS 6

Produces a tiled image from a source image by rotating the source at increments of 90 degrees.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Fourfold Translated Tile (CIFourfoldTranslatedTile)
###### First available: iOS 6

Produces a tiled image from a source image by applying 4 translation operations.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.
* Acute Angle (NSNumber - Angle) – The primary angle for the repeating translated tile. Small values create thin diamond tiles, and higher values create fatter translated tiles.

#### Outputs
* Image



## Gamma Adjust (CIGammaAdjust)
###### First available: iOS 5

Adjusts midtone brightness. This filter is typically used to compensate for nonlinear effects of displays. Adjusting the gamma effectively changes the slope of the transition between black and white.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Power (NSNumber - Scalar) – A gamma value to use to correct image brightness. The larger the value, the darker the result.

#### Outputs
* Image



## Gaussian Blur (CIGaussianBlur)
###### First available: iOS 6

Spreads source pixels by an amount specified by a Gaussian distribution.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Scalar) – The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.

#### Outputs
* Image



## Gaussian Gradient (CIGaussianGradient)
###### First available: iOS 5

Generates a gradient that varies from one color to another using a Gaussian distribution.

#### Inputs
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Color 1 (CIColor - Color) – The first color to use in the gradient.
* Color 2 (CIColor - Color) – The second color to use in the gradient.
* Radius (NSNumber - Distance) – The radius of the Gaussian distribution.

#### Outputs
* Image



## Glass Distortion (CIGlassDistortion)
###### First available: iOS 8

Distorts an image by applying a glass-like texture. The raised portions of the output image are the result of applying a texture map.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Texture (CIImage - Image) – A texture to apply to the source image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Scale (NSNumber - Distance) – The amount of texturing of the resulting image. The larger the value, the greater the texturing.

#### Outputs
* Image



## Glass Lozenge (CIGlassLozenge)
###### First available: iOS 9

Creates a lozenge-shaped lens and distorts the portion of the image over which the lens is placed.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Point 0 (CIVector - Position) – The x and y position that defines the center of the circle at one end of the lozenge.
* Point 1 (CIVector - Position) – The x and y position that defines the center of the circle at the other end of the lozenge.
* Radius (NSNumber - Distance) – The radius of the lozenge. The larger the radius, the wider the extent of the distortion.
* Refraction (NSNumber - Scalar) – The refraction of the glass.

#### Outputs
* Image



## Glide Reflected Tile (CIGlideReflectedTile)
###### First available: iOS 6

Produces a tiled image from a source image by translating and smearing the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Gloom (CIGloom)
###### First available: iOS 6

Dulls the highlights of an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the effect. The larger the radius, the greater the effect.
* Intensity (NSNumber - Scalar) – The intensity of the effect. A value of 0.0 is no effect. A value of 1.0 is the maximum effect.

#### Outputs
* Image



## Guided Filter (CIGuidedFilter)
###### First available: iOS 12

Upsamples a small image to the size of the guide image using the content of the guide to preserve detail.

#### Inputs
* Image (CIImage - Image) – A small image to upsample.
* A larger image to use as a guide. (CIImage) – A larger image to use as a guide.
* Radius (NSNumber - Scalar) – The distance from the center of the effect.
* Epsilon (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Hard Light Blend Mode (CIHardLightBlendMode)
###### First available: iOS 5

Either multiplies or screens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to screening. If the source image sample color is darker than 50% gray, the background is darkened, similar to multiplying. If the source image sample color is equal to 50% gray, the source image is not changed. Image samples that are equal to pure black or pure white result in pure black or white. The overall effect is similar to what you would achieve by shining a harsh spotlight on the source image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Hatched Screen (CIHatchedScreen)
###### First available: iOS 6

Simulates the hatched pattern of a halftone screen.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the hatched screen pattern
* Angle (NSNumber - Angle) – The angle of the pattern.
* Width (NSNumber - Distance) – The distance between lines in the pattern.
* Sharpness (NSNumber - Scalar) – The amount of sharpening to apply.

#### Outputs
* Image



## Height Field From Mask (CIHeightFieldFromMask)
###### First available: iOS 9

Produces a continuous three-dimensional, loft-shaped height field from a grayscale mask. The white values of the mask define those pixels that are inside the height field while the black values define those pixels that are outside. The field varies smoothly and continuously inside the mask, reaching the value 0 at the edge of the mask. You can use this filter with the Shaded Material filter to produce extremely realistic shaded objects.

#### Inputs
* Image (CIImage - Image) – The white values of the mask define those pixels that are inside the height field while the black values define those pixels that are outside. The field varies smoothly and continuously inside the mask, reaching the value 0 at the edge of the mask.
* Radius (NSNumber - Distance) – The distance from the edge of the mask for the smooth transition is proportional to the input radius. Larger values make the transition smoother and more pronounced. Smaller values make the transition approximate a fillet radius.

#### Outputs
* Image



## Hexagonal Pixelate (CIHexagonalPixellate)
###### First available: iOS 9

Displays an image as colored hexagons whose color is an average of the pixels they replace.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Scale (NSNumber - Distance) – The scale determines the size of the hexagons. Larger values result in larger hexagons.

#### Outputs
* Image



## Highlight and Shadow Adjust (CIHighlightShadowAdjust)
###### First available: iOS 5

Adjust the tonal mapping of an image while preserving spatial detail

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Scalar) – Shadow Highlight Radius
* Shadow Amount (NSNumber - Scalar) – The amount of adjustment to the shadows of the image.
* Highlight Amount (NSNumber - Scalar) – The amount of adjustment to the highlights of the image.

#### Outputs
* Image



## Histogram Display (CIHistogramDisplayFilter)
###### First available: iOS 8

Generates a displayable histogram image from the output of the “Area Histogram” filter.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Height (NSNumber - Scalar) – The height of the displayable histogram image.
* High Limit (NSNumber - Scalar) – The fraction of the right portion of the histogram image to make lighter.
* Low Limit (NSNumber - Scalar) – The fraction of the left portion of the histogram image to make darker

#### Outputs
* Image



## Hole Distortion (CIHoleDistortion)
###### First available: iOS 6

Creates a circular area that pushes the image pixels outward, distorting those pixels closest to the circle the most.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.

#### Outputs
* Image



## Hue Adjust (CIHueAdjust)
###### First available: iOS 5

Changes the overall hue, or tint, of the source pixels.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Angle (NSNumber - Angle) – An angle (in radians) to use to correct the hue of an image.

#### Outputs
* Image



## Hue Blend Mode (CIHueBlendMode)
###### First available: iOS 5

Uses the luminance and saturation values of the background with the hue of the source image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Hue/Saturation/Value Gradient (CIHueSaturationValueGradient)
###### First available: iOS 10

Generates a color wheel that shows hues and saturations for a specified value.

#### Inputs
* Value (NSNumber - Scalar) – No description available.
* Radius (NSNumber - Distance) – The distance from the center of the effect.
* Softness (NSNumber - Scalar) – No description available.
* Dither (NSNumber - Scalar) – No description available.
* Color Space (NSObject) – The CGColorSpaceRef that the color wheel should be generated in.

#### Outputs
* Image



## Kaleidoscope (CIKaleidoscope)
###### First available: iOS 9

Produces a kaleidoscopic image from a source image by applying 12-way symmetry.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Count (NSNumber - Scalar) – The number of reflections in the pattern.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle of reflection.

#### Outputs
* Image



## Lab ∆E (CILabDeltaE)
###### First available: iOS 11

Produces an image with the Lab ∆E difference values between two images. The result image will contain ∆E 1994 values between 0.0 and 100.0 where 2.0 is considered a just noticeable difference.

#### Inputs
* Image (CIImage - Image) – The first input image for comparison.
* Image2 (CIImage) – The second input image for comparison.

#### Outputs
* Image



## Lanczos Scale Transform (CILanczosScaleTransform)
###### First available: iOS 6

Produces a high-quality, scaled version of a source image. You typically use this filter to scale down an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Scale (NSNumber - Scalar) – The scaling factor to use on the image. Values less than 1.0 scale down the images. Values greater than 1.0 scale up the image.
* Aspect Ratio (NSNumber - Scalar) – The additional horizontal scaling factor to use on the image.

#### Outputs
* Image
* ImageNewScaleX:scaleY:
* ImageOldScaleX:scaleY:



## Lenticular Halo (CILenticularHaloGenerator)
###### First available: iOS 9

Simulates a halo that is generated by the diffraction associated with the spread of a lens. This filter is typically applied to another image to simulate lens flares and similar effects.

#### Inputs
* Center (CIVector - Position) – The x and y position to use as the center of the halo.
* Color (CIColor) – A color.
* Halo Radius (NSNumber - Distance) – The radius of the halo.
* Halo Width (NSNumber - Distance) – The width of the halo, from its inner radius to its outer radius.
* Halo Overlap (NSNumber - Scalar) – No description available.
* Striation Strength (NSNumber - Scalar) – The intensity of the halo colors. Larger values are more intense.
* Striation Contrast (NSNumber - Scalar) – The contrast of the halo colors. Larger values are higher contrast.
* Time (NSNumber - Scalar) – The duration of the effect.

#### Outputs
* Image



## Light Tunnel Distortion (CILightTunnel)
###### First available: iOS 6

Light tunnel distortion.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Center (CIVector - Position) – Center of the light tunnel.
* Rotation (NSNumber - Angle) – Rotation angle of the light tunnel.
* Radius (NSNumber - Distance) – Center radius of the light tunnel.

#### Outputs
* Image



## Lighten Blend Mode (CILightenBlendMode)
###### First available: iOS 5

Creates composite image samples by choosing the lighter samples (either from the source image or the background). The result is that the background image samples are replaced by any source image samples that are lighter. Otherwise, the background image samples are left unchanged.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Line Overlay (CILineOverlay)
###### First available: iOS 9

Creates a sketch that outlines the edges of an image in black, leaving the non-outlined portions of the image transparent. The result has alpha and is rendered in black, so it won’t look like much until you render it over another image using source over compositing.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* NR Noise Level (NSNumber - Scalar) – The noise level of the image (used with camera data) that gets removed before tracing the edges of the image. Increasing the noise level helps to clean up the traced edges of the image.
* NR Sharpness (NSNumber - Scalar) – The amount of sharpening done when removing noise in the image before tracing the edges of the image. This improves the edge acquisition.
* Edge Intensity (NSNumber - Scalar) – The accentuation factor of the Sobel gradient information when tracing the edges of the image. Higher values find more edges, although typically a low value (such as 1.0) is used.
* Threshold (NSNumber - Scalar) – This value determines edge visibility. Larger values thin out the edges.
* Contrast (NSNumber - Scalar) – The amount of anti-aliasing to use on the edges produced by this filter. Higher values produce higher contrast edges (they are less anti-aliased).

#### Outputs
* Image



## Line Screen (CILineScreen)
###### First available: iOS 6

Simulates the line pattern of a halftone screen.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the line screen pattern
* Angle (NSNumber - Angle) – The angle of the pattern.
* Width (NSNumber - Distance) – The distance between lines in the pattern.
* Sharpness (NSNumber - Scalar) – The sharpness of the pattern. The larger the value, the sharper the pattern.

#### Outputs
* Image



## Linear Burn Blend Mode (CILinearBurnBlendMode)
###### First available: iOS 8

Inverts the unpremultiplied source and background image sample color, inverts the sum, and then blends the result with the background according to the PDF basic compositing formula. Source image values that are white produce no change. Source image values that are black invert the background color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Linear Dodge Blend Mode (CILinearDodgeBlendMode)
###### First available: iOS 8

Unpremultiplies the source and background image sample colors, adds them, and then blends the result with the background according to the PDF basic compositing formula. Source image values that are black produces output that is the same as the background. Source image values that are non-black brighten the background color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Linear Gradient (CILinearGradient)
###### First available: iOS 5

Generates a gradient that varies along a linear axis between two defined endpoints.

#### Inputs
* Point 0 (CIVector - Position) – The starting position of the gradient -- where the first color begins.
* Point 1 (CIVector - Position) – The ending position of the gradient -- where the second color begins.
* Color 1 (CIColor - Color) – The first color to use in the gradient.
* Color 2 (CIColor - Color) – The second color to use in the gradient.

#### Outputs
* Image



## Linear to sRGB Tone Curve (CILinearToSRGBToneCurve)
###### First available: iOS 7

Converts an image in linear space to sRGB space.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Luminosity Blend Mode (CILuminosityBlendMode)
###### First available: iOS 5

Uses the hue and saturation of the background with the luminance of the source image. This mode creates an effect that is inverse to the effect created by the “Color Blend Mode” filter.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Mask to Alpha (CIMaskToAlpha)
###### First available: iOS 6

Converts a grayscale image to a white image that is masked by alpha. The white values from the source image produce the inside of the mask; the black values become completely transparent.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Masked Variable Blur (CIMaskedVariableBlur)
###### First available: iOS 8

Blurs an image according to the brightness levels in a mask image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Mask (CIImage) – No description available.
* Radius (NSNumber - Scalar) – The distance from the center of the effect.

#### Outputs
* Image



## Maximum Component (CIMaximumComponent)
###### First available: iOS 6

Converts an image to grayscale using the maximum of the three color components.

#### Inputs
* Image (CIImage - Image) – The image to process.

#### Outputs
* Image



## Maximum (CIMaximumCompositing)
###### First available: iOS 5

Computes the maximum value, by color component, of two input images and creates an output image using the maximum values. This is similar to dodging.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Median (CIMedianFilter)
###### First available: iOS 9

Computes the median value for a group of neighboring pixels and replaces each pixel value with the median. The effect is to reduce noise.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Mesh Generator (CIMeshGenerator)
###### First available: iOS 12

Generates a mesh from an array of line segments.

#### Inputs
* Width (NSNumber - Distance) – The width of the effect.
* Color (CIColor) – A color.
* Mesh (NSArray) – An array of line segments stored as an array of CIVectors each containing a start point and end point.

#### Outputs
* Image



## Minimum Component (CIMinimumComponent)
###### First available: iOS 6

Converts an image to grayscale using the minimum of the three color components.

#### Inputs
* Image (CIImage - Image) – The image to process.

#### Outputs
* Image



## Minimum (CIMinimumCompositing)
###### First available: iOS 5

Computes the minimum value, by color component, of two input images and creates an output image using the minimum values. This is similar to burning.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Mix (CIMix)
###### First available: iOS 12

Uses an amount parameter to interpolate between an image and a background image. When value is 0.0 or less, the result is the background image. When the value is 1.0 or more, the result is the image.

#### Inputs
* Image (CIImage - Image) – The image to use as a foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.
* Amount (NSNumber - Scalar) – The amount of the effect.

#### Outputs
* Image



## Mod (CIModTransition)
###### First available: iOS 6

Transitions from one image to another by revealing the target image through irregularly shaped holes.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Angle (NSNumber - Angle) – The angle of the mod hole pattern.
* Radius (NSNumber - Distance) – The radius of the undistorted holes in the pattern.
* Compression (NSNumber - Distance) – The amount of stretching applied to the mod hole pattern. Holes in the center are not distorted as much as those at the edge of the image.

#### Outputs
* Image



## Morphology Gradient (CIMorphologyGradient)
###### First available: iOS 11

Finds the edges of an image by returning the difference between the morphological minimum and maximum operations to the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The desired radius of the circular morphological operation to the image.

#### Outputs
* Image



## Morphology Maximum (CIMorphologyMaximum)
###### First available: iOS 11

Lightens areas of an image by applying a morphological maximum operation to the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The desired radius of the circular morphological operation to the image.

#### Outputs
* Image



## Morphology Minimum (CIMorphologyMinimum)
###### First available: iOS 11

Darkens areas of an image by applying a morphological maximum operation to the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The desired radius of the circular morphological operation to the image.

#### Outputs
* Image



## Motion Blur (CIMotionBlur)
###### First available: iOS 8.3

Blurs an image to simulate the effect of using a camera that moves a specified angle and distance while capturing the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
* Angle (NSNumber - Angle) – The angle of the motion determines which direction the blur smears.

#### Outputs
* Image



## Multiply Blend Mode (CIMultiplyBlendMode)
###### First available: iOS 5

Multiplies the source image samples with the background image samples. This results in colors that are at least as dark as either of the two contributing sample colors.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Multiply (CIMultiplyCompositing)
###### First available: iOS 5

Multiplies the color component of two input images and creates an output image using the multiplied values. This filter is typically used to add a spotlight or similar lighting effect to an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Nine Part Stretched (CINinePartStretched)
###### First available: iOS 10

Distorts an image by stretching an image based on two input breakpoints

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Breakpoint0 (CIVector - Position) – Lower left corner of image to retain before stretching begins.
* Breakpoint1 (CIVector - Position) – Upper right corner of image to retain after stretching ends.
* Grow Amount (CIVector - Offset) – No description available.

#### Outputs
* Image



## Nine Part Tiled (CINinePartTiled)
###### First available: iOS 10

Distorts an image by tiling an image based on two input breakpoints

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Breakpoint0 (CIVector - Position) – Lower left corner of image to retain before tiling begins.
* Breakpoint1 (CIVector - Position) – Upper right corner of image to retain after tiling ends.
* Grow Amount (CIVector - Offset) – No description available.
* Flip Y Tiles (NSNumber - Boolean) – Indicates that Y-Axis flip should occur.

#### Outputs
* Image



## Noise Reduction (CINoiseReduction)
###### First available: iOS 9

Reduces noise using a threshold value to define what is considered noise. Small changes in luminance below that value are considered noise and get a noise reduction treatment, which is a local blur. Changes above the threshold value are considered edges, so they are sharpened.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Noise Level (NSNumber - Scalar) – The amount of noise reduction. The larger the value, the more noise reduction.
* Sharpness (NSNumber - Scalar) – The sharpness of the final image. The larger the value, the sharper the result.

#### Outputs
* Image



## Op Tile (CIOpTile)
###### First available: iOS 9

Segments an image, applying any specified scaling and rotation, and then assembles the image again to give an op art appearance.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Scale (NSNumber - Scalar) – The scale determines the number of tiles in the effect.
* Angle (NSNumber - Angle) – The angle of a tile.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Overlay Blend Mode (CIOverlayBlendMode)
###### First available: iOS 5

Either multiplies or screens the source image samples with the background image samples, depending on the background color. The result is to overlay the existing image samples while preserving the highlights and shadows of the background. The background color mixes with the source image to reflect the lightness or darkness of the background.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## PDF417 Barcode Generator (CIPDF417BarcodeGenerator)
###### First available: iOS 9

Generate a PDF417 barcode image for message data.

#### Inputs
* Message (NSData) – The message to encode in the PDF417 Barcode
* Min Width (NSNumber) – The minimum width of the generated barcode in pixels.
* Max Width (NSNumber) – The maximum width of the generated barcode in pixels.
* Min Height (NSNumber) – The minimum height of the generated barcode in pixels.
* Max Height (NSNumber) – The maximum height of the generated barcode in pixels.
* Data Columns (NSNumber) – The number of data columns in the generated barcode
* Rows (NSNumber) – The number of rows in the generated barcode
* Preferred Aspect Ratio (NSNumber) – The preferred aspect ratio of the generated barcode
* Compaction Mode (NSNumber) – The compaction mode of the generated barcode.
* Compact Style (NSNumber) – Force a compact style Aztec code to @YES or @NO. Set to nil for automatic.
* Correction Level (NSNumber) – The correction level ratio of the generated barcode
* Always Specify Compaction (NSNumber) – Force compaction style to @YES or @NO. Set to nil for automatic.

#### Outputs
* Image
* CGImage



## Page Curl (CIPageCurlTransition)
###### First available: iOS 9

Transitions from one image to another by simulating a curling page, revealing the new image as the page curls.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Backside Image (CIImage) – The image that appears on the back of the source image, as the page curls to reveal the target image.
* Shading Image (CIImage - Image) – An image that looks like a shaded sphere enclosed in a square image.
* Extent (CIVector - Rectangle) – The extent of the effect.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Angle (NSNumber - Angle) – The angle of the curling page.
* Radius (NSNumber - Distance) – The radius of the curl.

#### Outputs
* Image



## Page Curl With Shadow (CIPageCurlWithShadowTransition)
###### First available: iOS 9

Transitions from one image to another by simulating a curling page, revealing the new image as the page curls.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Backside Image (CIImage) – The image that appears on the back of the source image, as the page curls to reveal the target image.
* Extent (CIVector - Rectangle) – The extent of the effect.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Angle (NSNumber - Angle) – The angle of the curling page.
* Radius (NSNumber - Distance) – The radius of the curl.
* Shadow Size (NSNumber - Distance) – The maximum size in pixels of the shadow.
* Shadow Amount (NSNumber - Distance) – The strength of the shadow.
* Shadow Extent (CIVector - Rectangle) – The rectagular portion of input image that will cast a shadow.

#### Outputs
* Image



## Parallelogram Tile (CIParallelogramTile)
###### First available: iOS 9

Warps an image by reflecting it in a parallelogram, and then tiles the result.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Acute Angle (NSNumber - Angle) – The primary angle for the repeating parallelogram tile. Small values create thin diamond tiles, and higher values create fatter parallelogram tiles.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Perspective Correction (CIPerspectiveCorrection)
###### First available: iOS 8

Apply a perspective correction to an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Top Left (CIVector - Position) – The top left coordinate to be perspective corrected.
* Top Right (CIVector - Position) – The top right coordinate to be perspective corrected.
* Bottom Right (CIVector - Position) – The bottom right coordinate to be perspective corrected.
* Bottom Left (CIVector - Position) – The bottom left coordinate to be perspective corrected.
* Crop (NSNumber - Boolean) – No description available.

#### Outputs
* Image



## Perspective Tile (CIPerspectiveTile)
###### First available: iOS 6

Applies a perspective transform to an image and then tiles the result.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Top Left (CIVector - Position) – The top left coordinate of a tile.
* Top Right (CIVector - Position) – The top right coordinate of a tile.
* Bottom Right (CIVector - Position) – The bottom right coordinate of a tile.
* Bottom Left (CIVector - Position) – The bottom left coordinate of a tile.

#### Outputs
* Image



## Perspective Transform (CIPerspectiveTransform)
###### First available: iOS 6

Alters the geometry of an image to simulate the observer changing viewing position. You can use the perspective filter to skew an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Top Left (CIVector - Position) – The top left coordinate to map the image to.
* Top Right (CIVector - Position) – The top right coordinate to map the image to.
* Bottom Right (CIVector - Position) – The bottom right coordinate to map the image to.
* Bottom Left (CIVector - Position) – The bottom left coordinate to map the image to.

#### Outputs
* Image



## Perspective Transform with Extent (CIPerspectiveTransformWithExtent)
###### First available: iOS 6

Alters the geometry of an image to simulate the observer changing viewing position. You can use the perspective filter to skew an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Extent (CIVector - Rectangle) – A rectangle that defines the extent of the effect.
* Top Left (CIVector - Position) – No description available.
* Top Right (CIVector - Position) – No description available.
* Bottom Right (CIVector - Position) – No description available.
* Bottom Left (CIVector - Position) – No description available.

#### Outputs
* Image



## Photo Effect Chrome (CIPhotoEffectChrome)
###### First available: iOS 7

Apply a ‘Chrome’ style effect to an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Fade (CIPhotoEffectFade)
###### First available: iOS 7

Apply a ‘Fade’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Instant (CIPhotoEffectInstant)
###### First available: iOS 7

Apply a ‘Instant’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Mono (CIPhotoEffectMono)
###### First available: iOS 7

Apply a ‘Mono’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Noir (CIPhotoEffectNoir)
###### First available: iOS 7

Apply a ‘Noir’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Process (CIPhotoEffectProcess)
###### First available: iOS 7

Apply a ‘Process’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Tonal (CIPhotoEffectTonal)
###### First available: iOS 7

Apply a ‘Tonal’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Photo Effect Transfer (CIPhotoEffectTransfer)
###### First available: iOS 7

Apply a ‘Transfer’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Pin Light Blend Mode (CIPinLightBlendMode)
###### First available: iOS 8

Unpremultiplies the source and background image sample color, combines them according to the relative difference, and then blends the result with the background according to the PDF basic compositing formula. Source image values that are brighter than the destination will produce an output that is lighter than the destination. Source image values that are darker than the destination will produce an output that is darker than the destination.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Pinch Distortion (CIPinchDistortion)
###### First available: iOS 6

Creates a rectangular-shaped area that pinches source pixels inward, distorting those pixels closest to the rectangle the most.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Scale (NSNumber - Scalar) – The amount of pinching. A value of 0.0 has no effect. A value of 1.0 is the maximum pinch.

#### Outputs
* Image



## Pixelate (CIPixellate)
###### First available: iOS 6

Makes an image blocky.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Scale (NSNumber - Distance) – The scale determines the size of the squares. Larger values result in larger squares.

#### Outputs
* Image



## Pointillize (CIPointillize)
###### First available: iOS 9

Renders the source image in a pointillistic style.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius of the circles in the resulting pattern.
* Center (CIVector - Position) – The x and y position to use as the center of the effect

#### Outputs
* Image



## QR Code Generator (CIQRCodeGenerator)
###### First available: iOS 7

Generate a QR Code image for message data.

#### Inputs
* Message (NSData) – The message to encode in the QR Code
* Correction Level (NSString) – QR Code correction level L, M, Q, or H.

#### Outputs
* Image
* CGImage



## Radial Gradient (CIRadialGradient)
###### First available: iOS 5

Generates a gradient that varies radially between two circles having the same center. It is valid for one of the two circles to have a radius of 0.

#### Inputs
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius 1 (NSNumber - Distance) – The radius of the starting circle to use in the gradient.
* Radius 2 (NSNumber - Distance) – The radius of the ending circle to use in the gradient.
* Color 1 (CIColor - Color) – The first color to use in the gradient.
* Color 2 (CIColor - Color) – The second color to use in the gradient.

#### Outputs
* Image



## Random Generator (CIRandomGenerator)
###### First available: iOS 6

Generates an image of infinite extent whose pixel values are made up of four independent, uniformly-distributed random numbers in the 0 to 1 range.

#### Inputs

#### Outputs
* Image



## Ripple (CIRippleTransition)
###### First available: iOS 9

Transitions from one image to another by creating a circular wave that expands from the center point, revealing the new image in the wake of the wave.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Shading Image (CIImage - Image) – An image that looks like a shaded sphere enclosed in a square image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Extent (CIVector - Rectangle) – A rectangle that defines the extent of the effect.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Width (NSNumber - Distance) – The width of the ripple.
* Scale (NSNumber - Scalar) – A value that determines whether the ripple starts as a bulge (higher value) or a dimple (lower value).

#### Outputs
* Image



## Row Average (CIRowAverage)
###### First available: iOS 9

Calculates the average color for each row of the specified area in an image, returning the result in a 1D image.

#### Inputs
* Image (CIImage - Image) – The image to process.
* Extent (CIVector - Rectangle) – A rectangle that specifies the subregion of the image that you want to process.

#### Outputs
* Image



## sRGB Tone Curve to Linear (CISRGBToneCurveToLinear)
###### First available: iOS 7

Converts an image in sRGB space to linear space.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Saliency Map Filter (CISaliencyMapFilter)
###### First available: iOS 12

Generates output image as a saliency map of the input image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Sample Nearest (CISampleNearest)
###### First available: iOS 12

Produces an image that forces the image sampling to ‘nearest’ mode instead of the default ‘linear’ mode. This filter can be used to alter the behavior of filters that alter the geometry of an image. The output of this filter should be passed as the input to the geometry filter. For example, passing the output of this filter to CIAffineTransform can be used to produce a pixelated upsampled image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Saturation Blend Mode (CISaturationBlendMode)
###### First available: iOS 5

Uses the luminance and hue values of the background with the saturation of the source image. Areas of the background that have no saturation (that is, pure gray areas) do not produce a change.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Screen Blend Mode (CIScreenBlendMode)
###### First available: iOS 5

Multiplies the inverse of the source image samples with the inverse of the background image samples. This results in colors that are at least as light as either of the two contributing sample colors.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Sepia Tone (CISepiaTone)
###### First available: iOS 5

Maps the colors of an image to various shades of brown.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Intensity (NSNumber - Scalar) – The intensity of the sepia effect. A value of 1.0 creates a monochrome sepia image. A value of 0.0 has no effect on the image.

#### Outputs
* Image



## Shaded Material (CIShadedMaterial)
###### First available: iOS 9

Produces a shaded image from a height field. The height field is defined to have greater heights with lighter shades, and lesser heights (lower areas) with darker shades. You can combine this filter with the ”Height Field From Mask” filter to produce quick shadings of masks, such as text.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Shading Image (CIImage - Image) – The image to use as the height field. The resulting image has greater heights with lighter shades, and lesser heights (lower areas) with darker shades.
* Scale (NSNumber - Distance) – The scale of the effect. The higher the value, the more dramatic the effect.

#### Outputs
* Image



## Sharpen Luminance (CISharpenLuminance)
###### First available: iOS 6

Increases image detail by sharpening. It operates on the luminance of the image; the chrominance of the pixels remains unaffected.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Sharpness (NSNumber - Scalar) – The amount of sharpening to apply. Larger values are sharper.
* Radius (NSNumber - Scalar) – The distance from the center of the effect.

#### Outputs
* Image



## Sixfold Reflected Tile (CISixfoldReflectedTile)
###### First available: iOS 6

Produces a tiled image from a source image by applying a 6-way reflected symmetry.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Sixfold Rotated Tile (CISixfoldRotatedTile)
###### First available: iOS 6

Produces a tiled image from a source image by rotating the source at increments of 60 degrees.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Smooth Linear Gradient (CISmoothLinearGradient)
###### First available: iOS 6

Generates a gradient that varies along a linear axis between two defined endpoints.

#### Inputs
* Point 0 (CIVector - Position) – The starting position of the gradient -- where the first color begins.
* Point 1 (CIVector - Position) – The ending position of the gradient -- where the second color begins.
* Color 1 (CIColor - Color) – The first color to use in the gradient.
* Color 2 (CIColor - Color) – The second color to use in the gradient.

#### Outputs
* Image



## Soft Light Blend Mode (CISoftLightBlendMode)
###### First available: iOS 5

Either darkens or lightens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to dodging. If the source image sample color is darker than 50% gray, the background is darkened, similar to burning. If the source image sample color is equal to 50% gray, the background is not changed. Image samples that are equal to pure black or pure white produce darker or lighter areas, but do not result in pure black or white. The overall effect is similar to what you would achieve by shining a diffuse spotlight on the source image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Source Atop (CISourceAtopCompositing)
###### First available: iOS 5

Places the source image over the background image, then uses the luminance of the background image to determine what to show. The composite shows the background image and only those portions of the source image that are over visible parts of the background.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Source In (CISourceInCompositing)
###### First available: iOS 5

Uses the second image to define what to leave in the source image, effectively cropping the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Source Out (CISourceOutCompositing)
###### First available: iOS 5

Uses the second image to define what to take out of the first image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Source Over (CISourceOverCompositing)
###### First available: iOS 5

Places the second image over the first.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Spot Color (CISpotColor)
###### First available: iOS 9

Replaces one or more color ranges with spot colors.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center Color 1 (CIColor) – The center value of the first color range to replace.
* Replacement Color 1 (CIColor) – A replacement color for the first color range.
* Closeness 1 (NSNumber - Scalar) – A value that indicates how close the first color must match before it is replaced.
* Contrast 1 (NSNumber - Scalar) – The contrast of the first replacement color.
* Center Color 2 (CIColor) – The center value of the second color range to replace.
* Replacement Color 2 (CIColor) – A replacement color for the second color range.
* Closeness 2 (NSNumber - Scalar) – A value that indicates how close the second color must match before it is replaced.
* Contrast 2 (NSNumber - Scalar) – The contrast of the second replacement color.
* Center Color 3 (CIColor) – The center value of the third color range to replace.
* Replacement Color 3 (CIColor) – A replacement color for the third color range.
* Closeness 3 (NSNumber - Scalar) – A value that indicates how close the third color must match before it is replaced.
* Contrast 3 (NSNumber - Scalar) – The contrast of the third replacement color.

#### Outputs
* Image



## Spot Light (CISpotLight)
###### First available: iOS 9

Applies a directional spotlight effect to an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Light Position (CIVector - Position3) – The x and y position of the spotlight.
* Light Points At (CIVector - Position3) – The x and y position that the spotlight points at.
* Brightness (NSNumber - Distance) – The brightness of the spotlight.
* Concentration (NSNumber - Scalar) – The spotlight size. The smaller the value, the more tightly focused the light beam.
* Color (CIColor - OpaqueColor) – The color of the spotlight.

#### Outputs
* Image



## Star Shine (CIStarShineGenerator)
###### First available: iOS 6

Generates a starburst pattern. The output image is typically used as input to another filter

#### Inputs
* Center (CIVector - Position) – The x and y position to use as the center of the star.
* Color (CIColor) – The color to use for the outer shell of the circular star.
* Radius (NSNumber - Distance) – The radius of the star.
* Cross Scale (NSNumber - Scalar) – The size of the cross pattern.
* Cross Angle (NSNumber - Angle) – The angle of the cross pattern.
* Cross Opacity (NSNumber - Scalar) – The opacity of the cross pattern.
* Cross Width (NSNumber - Distance) – The width of the cross pattern.
* Epsilon (NSNumber - Scalar) – The length of the cross spikes.

#### Outputs
* Image



## Straighten (CIStraightenFilter)
###### First available: iOS 5

Rotates a source image by the specified angle in radians. The image is then scaled and cropped so that the rotated image fits the extent of the input image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Angle (NSNumber - Angle) – An angle in radians.

#### Outputs
* Image



## Stretch Crop (CIStretchCrop)
###### First available: iOS 9

Distorts an image by stretching and or cropping to fit a target size.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Size (CIVector - Position) – The size in pixels of the output image.
* Crop Amount (NSNumber - Scalar) – Determines if and how much cropping should be used to achieve the target size. If value is 0 then only stretching is used. If 1 then only cropping is used.
* Center Stretch Amount (NSNumber - Scalar) – Determine how much the center of the image is stretched if stretching is used. If value is 0 then the center of the image maintains the original aspect ratio. If 1 then the image is stretched uniformly.

#### Outputs
* Image



## Stripes (CIStripesGenerator)
###### First available: iOS 5

Generates a stripe pattern. You can control the color of the stripes, the spacing, and the contrast.

#### Inputs
* Center (CIVector - Position) – The x and y position to use as the center of the stripe pattern.
* Color 1 (CIColor) – A color to use for the odd stripes.
* Color 2 (CIColor) – A color to use for the even stripes.
* Width (NSNumber - Distance) – The width of a stripe.
* Sharpness (NSNumber - Scalar) – The sharpness of the stripe pattern. The smaller the value, the more blurry the pattern. Values range from 0.0 to 1.0.

#### Outputs
* Image



## Subtract Blend Mode (CISubtractBlendMode)
###### First available: iOS 8

Unpremultiplies the source and background image sample colors, subtracts the source from the background, and then blends the result with the background according to the PDF basic compositing formula. Source image values that are black produces output that is the same as the background. Source image values that are non-black darken the background color values.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Background Image (CIImage - Image) – The image to use as a background image.

#### Outputs
* Image



## Sunbeams (CISunbeamsGenerator)
###### First available: iOS 9

Generates a sun effect. You typically use the output of the sunbeams filter as input to a composite filter.

#### Inputs
* Center (CIVector - Position) – The x and y position to use as the center of the sunbeam pattern
* Color (CIColor) – The color of the sun.
* Sun Radius (NSNumber - Distance) – The radius of the sun.
* Maximum Striation Radius (NSNumber - Scalar) – The radius of the sunbeams.
* Striation Strength (NSNumber - Scalar) – The intensity of the sunbeams. Higher values result in more intensity.
* Striation Contrast (NSNumber - Scalar) – The contrast of the sunbeams. Higher values result in more contrast.
* Time (NSNumber - Scalar) – The duration of the effect.

#### Outputs
* Image



## Swipe (CISwipeTransition)
###### First available: iOS 6

Transitions from one image to another by simulating a swiping action.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Target Image (CIImage - Image) – The target image for a transition.
* Extent (CIVector - Rectangle) – The extent of the effect.
* Color (CIColor - OpaqueColor) – The color of the swipe.
* Time (NSNumber - Time) – The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
* Angle (NSNumber - Angle) – The angle of the swipe.
* Width (NSNumber - Distance) – The width of the swipe
* Opacity (NSNumber - Scalar) – The opacity of the swipe.

#### Outputs
* Image



## Temperature and Tint (CITemperatureAndTint)
###### First available: iOS 5

Adapt the reference white point for an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Neutral (CIVector - Offset) – No description available.
* Target Neutral (CIVector - Offset) – No description available.

#### Outputs
* Image



## Text Image Generator (CITextImageGenerator)
###### First available: iOS 11

Generate an image from a string and font information.

#### Inputs
* Text (NSString) – No description available.
* Font Name (NSString) – No description available.
* Font Size (NSNumber - Scalar) – No description available.
* Scale Factor (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Thermal (CIThermal)
###### First available: iOS 10

Apply a ‘Thermal’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Tone Curve (CIToneCurve)
###### First available: iOS 5

Adjusts tone response of the R, G, and B channels of an image. The input points are five x,y values that are interpolated using a spline curve. The curve is applied in a perceptual (gamma 2) version of the working space.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Point 0 (CIVector - Offset) – No description available.
* Point 1 (CIVector - Offset) – No description available.
* Point 2 (CIVector - Offset) – No description available.
* Point 3 (CIVector - Offset) – No description available.
* Point 4 (CIVector - Offset) – No description available.

#### Outputs
* Image



## Torus Lens Distortion (CITorusLensDistortion)
###### First available: iOS 9

Creates a torus-shaped lens and distorts the portion of the image over which the lens is placed.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the torus.
* Radius (NSNumber - Distance) – The outer radius of the torus.
* Width (NSNumber - Distance) – The width of the ring.
* Refraction (NSNumber - Scalar) – The refraction of the glass.

#### Outputs
* Image



## Triangle Kaleidoscope (CITriangleKaleidoscope)
###### First available: iOS 6

Maps a triangular portion of image to a triangular area and then generates a kaleidoscope effect.

#### Inputs
* Image (CIImage - Image) – Input image to generate kaleidoscope effect from.
* Point (CIVector - Position) – The x and y position to use as the center of the triangular area in the input image.
* Size (NSNumber - Scalar) – The size in pixels of the triangle.
* Rotation (NSNumber - Angle) – Rotation angle of the triangle.
* Decay (NSNumber - Scalar) – The decay determines how fast the color fades from the center triangle.

#### Outputs
* Image



## Triangle Tile (CITriangleTile)
###### First available: iOS 9

Maps a triangular portion of image to a triangular area and then tiles the result.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Twelvefold Reflected Tile (CITwelvefoldReflectedTile)
###### First available: iOS 6

Produces a tiled image from a source image by applying a 12-way reflected symmetry.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The x and y position to use as the center of the effect
* Angle (NSNumber - Angle) – The angle (in radians) of the tiled pattern.
* Width (NSNumber - Distance) – The width of a tile.

#### Outputs
* Image



## Twirl Distortion (CITwirlDistortion)
###### First available: iOS 5

Rotates pixels around a point to give a twirling effect. You can specify the number of rotations as well as the center and radius of the effect.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Angle (NSNumber - Angle) – The angle (in radians) of the twirl. Values can be positive or negative.

#### Outputs
* Image



## Unsharp Mask (CIUnsharpMask)
###### First available: iOS 6

Increases the contrast of the edges between pixels of different colors in an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Radius (NSNumber - Distance) – The radius around a given pixel to apply the unsharp mask. The larger the radius, the more of the image is affected.
* Intensity (NSNumber - Scalar) – The intensity of the effect. The larger the value, the more contrast in the affected area.

#### Outputs
* Image



## Vibrance (CIVibrance)
###### First available: iOS 5

Adjusts the saturation of an image while keeping pleasing skin tones.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Amount (NSNumber - Scalar) – The amount to adjust the saturation.

#### Outputs
* Image



## Vignette (CIVignette)
###### First available: iOS 5

Applies a vignette shading to the corners of an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Intensity (NSNumber - Scalar) – The intensity of the effect.
* Radius (NSNumber - Scalar) – The distance from the center of the effect.

#### Outputs
* Image



## Vignette Effect (CIVignetteEffect)
###### First available: iOS 7

Applies a vignette shading to the corners of an image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The distance from the center of the effect.
* Intensity (NSNumber - Scalar) – The intensity of the effect.
* Falloff (NSNumber - Scalar) – No description available.

#### Outputs
* Image



## Vortex Distortion (CIVortexDistortion)
###### First available: iOS 6

Rotates pixels around a point to simulate a vortex. You can specify the number of rotations as well the center and radius of the effect. 

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Radius (NSNumber - Distance) – The radius determines how many pixels are used to create the distortion. The larger the radius, the wider the extent of the distortion.
* Angle (NSNumber - Angle) – The angle (in radians) of the vortex.

#### Outputs
* Image



## White Point Adjust (CIWhitePointAdjust)
###### First available: iOS 5

Adjusts the reference white point for an image and maps all colors in the source using the new reference.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Color (CIColor - Color) – A color to use as the white point.

#### Outputs
* Image



## X-Ray (CIXRay)
###### First available: iOS 10

Apply a ‘XRay’ style effect to an image

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.

#### Outputs
* Image



## Zoom Blur (CIZoomBlur)
###### First available: iOS 8.3

Simulates the effect of zooming the camera while capturing the image.

#### Inputs
* Image (CIImage - Image) – The image to use as an input image. For filters that also use a background image, this is the foreground image.
* Center (CIVector - Position) – The center of the effect as x and y coordinates.
* Amount (NSNumber - Distance) – The zoom-in amount. Larger values result in more zooming in.

#### Outputs
* Image



