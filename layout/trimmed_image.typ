#let trimmed-image = (path, trim: (:), alt: none) => context {
  let img = image(path)
  // Get dimensions of the source image
  let dims = measure(img)

  layout(size => {
    let left = trim.at("left", default: 0.0%)
    let right = trim.at("right", default: 0.0%)

    let top = trim.at("top", default: 0.0%)
    let bottom = trim.at("bottom", default: 0.0%)

    let width-rel-trimmed = 100.0% - left - right
    let height-rel-trimmed = 100.0% - top - bottom

    let width-source-trimmed = dims.width * width-rel-trimmed
    let height-source-trimmed = dims.height * height-rel-trimmed

    // Aspect ratio h/w of the layout (available space)
    let aspect-height-layout = size.height / size.width
    // Aspect ratio h/w of the trimmed image
    let aspect-height-trimmed = height-source-trimmed / width-source-trimmed

    let width-final-trimmed = none
    let height-final-trimmed = none

    // Compute final size of trimmed image 
    // by expanding along dimension that first hits the layout constraints
    if aspect-height-layout >= aspect-height-trimmed {
      // Expand width of image
      width-final-trimmed = size.width
      height-final-trimmed = aspect-height-trimmed * width-final-trimmed
    } else {
      // Expand height of image
      height-final-trimmed = size.height
      width-final-trimmed = size.height / aspect-height-trimmed
    }

    // Compute the hypothetical size of the image without trimming
    let width-final-untrimmed = width-final-trimmed / float(width-rel-trimmed)
    let height-final-untrimmed = height-final-trimmed / float(height-rel-trimmed)

    box(
      clip: true, 
      inset: (
          top: -(top * height-final-untrimmed), 
          bottom: -(bottom * height-final-untrimmed),
          left: -(left * width-final-untrimmed),
          right: -(right * width-final-untrimmed)
        ), 
      // TODO: Handle explicit sizing according to a parameter (e.g. don't scale over DPI limits)
      image(path, width: width-final-untrimmed, height: height-final-untrimmed, alt: alt)
    )
  })
}
