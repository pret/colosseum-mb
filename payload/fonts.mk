graphics/fonts/font0_lat.2bpp: graphics/fonts/font0_lat.png
	$(RSFONT) $< $@ 254 1

graphics/fonts/font1_lat.2bpp: graphics/fonts/font1_lat.png
	$(RSFONT) $< $@ 110 2

graphics/fonts/font0_jpn.2bpp: graphics/fonts/font0_jpn.png
	$(RSFONT) $< $@ 254 1

graphics/fonts/font1_jpn.2bpp: graphics/fonts/font1_jpn.png
	$(RSFONT) $< $@ 110 2

graphics/fonts/font_null.2bpp: graphics/fonts/font_null.png
	$(RSFONT) $< $@ 254 1
