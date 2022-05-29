PCB=board_simple/m5atom-2x-thermistor.kicad_pcb


.PHONY: plot

plot: FAB/m5atom-2x-thermistor.zip

FAB/%.zip: board_simple/%.kicad_pcb
	mkdir -p $(dir $@)
	
	scripts/plot_fab.py $< $(dir $@)$*
	
	7z a $@ $(dir $@)$*


.PHONY: pos2cpl
pos2cpl:
	python scripts/kicad-jlcpcb-bom-plugin/kicad_pos_to_cpl.py\
		FAB/m5atom-2x-thermistor-top-pos.csv\
		FAB/m5atom-2x-thermistor-top-pos.cpl.csv\
		board/overrides.json


.PHONY: dev
dev:
	git submodule update --init --recursive


.PHONY: clean
clean:
	rm -rf FAB