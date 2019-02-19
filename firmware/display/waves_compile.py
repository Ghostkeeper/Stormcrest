#Any copyright is dedicated to the public domain. See LICENSE.md for more details.

"""
Script that packs waves.png into a compact data array of pixel brightness values
as a C literal.

This script will load the file waves.png and output a file sprite_waves.h that
can be included in a preprocessor directive to get the waves sprite data. When
including that header, a variable "sprite_waves_#" will be created for each size
(in place of the #). That variable will be a 3D array of bytes.
* The first dimension iterates over the individual images (8 for each size).
* The second dimension iterates over the colours for each image (7 colours for
  each image.
* The third dimension is the pixel data. These are monochrome images, so each
  bit is a pixel.

This script depends on the Pillow image library.
"""

from PIL import Image #Decodes PNG files for us.

sprite_sizes = [(8, 4), (6, 3), (4, 2), (4, 1)] #Each different size sprite, its dimensions.
sprite_counts = [8, 8, 8, 8] #Each different size sprite, how many are there?
sprite_spacing = 4 #Vertical spacing of the sprite. Each sprite starts on y = a multiple of this.
sprite_colours = 7 #Number of colours to encode. Each colour has to be drawn as a separate monochrome image! The colour 0 is considered transparent and will not be drawn.

if __name__ == "__main__":
	image = Image.open("waves.png")
	data = list(image.getdata())
	with open("waves.h", "w") as f:
		size_start_y = 0
		for size_index in range(len(sprite_sizes)):
			size = sprite_sizes[size_index]
			bytes_per_sprite = int((size[0] * size[1] + 7) / 8)
			f.write("static uint8_t sprite_waves_" + str(size_index) + "[][" + str(sprite_colours) + "][" + str(bytes_per_sprite) + "] = {")
			count = sprite_counts[size_index]
			for image_index in range(count):
				f.write("{")
				bit_data = [[0] * bytes_per_sprite for i in range(sprite_colours)] #Create one monochrome image for each colour.
				current_bit = 7
				start_y = size_start_y + sprite_spacing * image_index
				for y in range(size[1]):
					for x in range(size[0]):
						colour = int(data[(start_y + y) * image.width + x] * (sprite_colours + 1) / 255)
						for colour_index in range(sprite_colours):
							new_bit = (1 if colour == (colour_index + 1) else 0) << current_bit
							bit_data[colour_index][int((y * size[1] + x) / 8)] = bit_data[colour_index][int((y * size[1] + x) / 8)] | new_bit
						current_bit = (current_bit - 1) % 8
				for colour_index in range(sprite_colours):
					f.write("{")
					f.write(", ".join((str(byt) for byt in bit_data[colour_index])))
					f.write("}, ")
				f.write("}, ")
			f.write("};\n")
			size_start_y += sprite_spacing * count