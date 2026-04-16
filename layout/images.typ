
#let show_images = true
#let ba_image(path, width, caption) = figure(
  if show_images { image(path, width: width) } else { hide(image(path, width: width)) },
  caption: caption,
) 
