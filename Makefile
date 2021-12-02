OUT_ZIP=FreshEmoji.zip
SH=sh
DLR=curl
DLR_FLAGS=-L

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): META-INF module.prop
	@echo -e '\e[1;31mBuilding $(OUT_ZIP)\e[m'
	bsdtar -a -cf $(OUT_ZIP) *

test:
	$(SH) -n META-INF/com/google/android/update-binary
	$(SH) -n META-INF/com/google/android/updater-script

update:
	$(DLR) $(DLR_FLAGS) https://github.com/googlefonts/noto-emoji/archive/refs/heads/main.zip -o upstream.zip
	bsdtar -xf upstream.zip noto-emoji-main/fonts/NotoColorEmoji.ttf
	mv noto-emoji-main/fonts/NotoColorEmoji.ttf system/fonts/

clean:
	rm -f $(OUT_ZIP)
	rm -f upstream.zip
	rm -rf noto-emoji-main