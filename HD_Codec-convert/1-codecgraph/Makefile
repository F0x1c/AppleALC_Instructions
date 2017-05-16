PREFIX = /usr/local
DOTTY = dot

samples = \
	abit-kn9-ultra \
	acer-tm4070 acer-aspire-x1700 \
	alienware-m15x \
	apple-imac24 apple-macbook apple-macbook3_1 \
	arima-820di1 \
	asus-eeepc-701 \
	asus-m2nbp-vm asus-m2npv-vm asus-p5b-deluxe-wifi asus-m2a-vm-hdmi \
	asus-p5ld2-vm asus-p5gc-mx asus-m2n-vm-dvi asus-p5kc \
	asus-w2p asus-w5f asus-x55sv asus-f6s0 asus-a6jc-q077 \
	clevo-m540se clevo-m720r clevo-m720sr \
	compal-jft02 \
	compaq-presario-f755la \
	corrino-691sr \
	dell-inspiron-530 dell-inspiron-6400 \
	dell-latitude-120l dell-latitude-d520 dell-latitude-d620 \
	dell-latitude-d820 \
	dell-precision-490 \
	dell-studio-15 \
	everex-cloudbook \
	fujitsu-siemens-amilo-pi-1505 \
	gateway-mt3707 gateway-mp6954 \
	gigabyte-ma790fx-ds5 gigabyte-ga965p-ds4 \
	hp-dc5750 hp-dx2200 hp-dx2250 \
	hp-atlantis hp-spartan hp-victoria hp-spartan-ng \
	hp-nx7400 \
	hp-samba hp-nettle hp-lucknow \
	hp-pavilion-dv9782eg hp-pavilion-tx1420us hp-pavilion-dv7 \
	intel-dg965ss intel-dp965lt \
	lenovo-3000-n100 lenovo-thinkpad-t60 lenovo-thinkpad-t61 lenovo-f41a \
	lenovo-thinkpad-sl500 lenovo-w500 lenovo-ideapad-y430 \
	lg-lw20 lg-lw60 lg-le50 lg-p300 \
	medion-rim2050 \
	msi-ms-7267 msi-p35-neo msi-k9n6sgm-v \
	nec-m370 \
	panasonic-cf52-toughbook \
	quanta-il1 \
	samsung-q45 \
	shuttle-xpc-sg33g5m \
	sony-vaio-sz110 sony-vaio-vgn-s5vpb sony-vaio-vgc-rc102 \
	sony-vaio-vgn-g21xp sony-vaio-fe41e \
	toshiba-satellite-p105 toshiba-qosmio-f30-111 \
	toshiba-equium-l30149 toshiba-tecra-m9 \
	uniwill-m30

txtfiles = $(addprefix samples/, $(addsuffix .txt, $(samples)))
psfiles = $(addprefix out/, $(addsuffix .ps, $(samples)))
dotfiles = $(addprefix out/, $(addsuffix .dot, $(samples)))
pngfiles = $(addprefix out/, $(addsuffix .png, $(samples)))
svgfiles = $(addprefix out/, $(addsuffix .svg, $(samples)))

all:

dot: $(dotfiles)
ps: $(psfiles)
png: $(pngfiles)
svg: $(svgfiles)

install:
	install -m755 -D codecgraph $(DESTDIR)$(PREFIX)/bin/codecgraph
	install -m755 -D codecgraph.py $(DESTDIR)$(PREFIX)/bin/codecgraph.py
	install -m644 -D codecgraph.1 $(DESTDIR)$(PREFIX)/man/man1/codecgraph.1

thumbs: png
	for p in $(pngfiles);do \
		convert -resize 10%x10% $$p out/thumb-`basename $$p`; \
		echo "converting $$p"; \
	done

out/%.dot: samples/%.txt codecgraph.py
	./codecgraph.py $< > $@

%.ps: %.dot
	$(DOTTY) -Tps -o $@ $<

%.png: %.dot
	$(DOTTY) -Tpng -o $@ $<

%.svg: %.dot
	$(DOTTY) -Tsvg -o $@ $<

clean:
	rm -f $(psfiles)
	rm -f $(dotfiles)
	rm -f $(pngfiles)

