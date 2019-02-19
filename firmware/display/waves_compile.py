#Any copyright is dedicated to the public domain. See LICENSE.md for more details.

"""
Script that packs waves.png into a compact data array of pixel brightness values
as a C literal.

This script will load the file waves.png and output a file sprite_waves.h that
can be included in a preprocessor directive to get the waves sprite data. When
including that header, a variable "sprite_waves_#" will be created for each size
(in place of the #).

This script depends on the Pillow image library.
"""

from PIL import Image #Decodes PNG files for us.

sprite_sizes = [(8, 4), (6, 3), (4, 2), (4, 1)] #Each different size sprite, its dimensions.
sprite_counts = [8, 8, 8, 8] #Each different size sprite, how many are there?
sprite_spacing = 4 #Vertical spacing of the sprite. Each sprite starts on y = a multiple of this.

if __name__ == "__main__":
	image = Image.open("waves.png")
	data = list(image.getdata())
	with open("waves.h", "w") as f:
		size_start_y = 0
		for size_index in range(len(sprite_sizes)):
			f.write("static uint8_t sprite_waves_" + str(size_index) + " = {")
			size = sprite_sizes[size_index]
			count = sprite_counts[size_index]
			for image_index in range(count):
				start_y = size_start_y + sprite_spacing * image_index
				for y in range(start_y, start_y + size[1]):
					for x in range(size[0]):
						f.write(str(data[y * image.width + x]))
						f.write(", ")
			f.write("};\n")
			size_start_y += sprite_spacing * count