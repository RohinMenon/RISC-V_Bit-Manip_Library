TOPFILE=bbox.bsv
BSVINCDIR=.:%/Libraries:./src
BSCDEFINES=RV64
VERILOGDIR=verilog/
BUILDDIR=intermediate/

include bbox_verif/Makefile.verif

.DEFAULT_GOAL := simulate

.PHONY: simulate
simulate:
	@make generate_verilog
	@make sim
	@make clean_build

.PHONY: generate_verilog
generate_verilog:
	@make clean_build
	@mkdir -p $(VERILOGDIR) $(BUILDDIR)
	@bsc -u -verilog -elab -vdir ./verilog -bdir ./intermediate -info-dir ./intermediate +RTS -K40000M -RTS -check-assert  -keep-fires -opt-undetermined-vals -remove-false-rules -remove-empty-rules -remove-starved-rules -remove-dollar -unspecified-to X -show-schedule -show-module-use  -suppress-warnings G0010:T0054:G0020:G0024:G0023:G0096:G0036:G0117:G0015 -D $(BSCDEFINES) -p $(BSVINCDIR) $(TOPFILE)
	@make print-BSCDEFINES | grep "BSCDEFINES" > bbox_verif/base.txt

.PHONY: clean_build
clean_build:
	@make clean
	@rm -rf $(VERILOGDIR) $(BUILDDIR)
	@rm -rf bbox_verif/__pycache__ bbox_verif/base.txt
	@rm -rf results.xml 
	@echo "Cleaned"

.PHONY: print-%
print-%:
	@echo $* = $($*)
