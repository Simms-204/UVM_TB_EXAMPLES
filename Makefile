#Makefile for UVM Testbench - mod12 counter

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS
# (or override on the command line, e.g.  make regress SIMULATOR=VCS)

SIMULATOR = Questa

#FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64
FSDB_PATH = /home/cad/eda/SYNOPSYS/verdi_vX-2025.06/verdi/X-2025.06/share/PLI/VCS/linux64

# Run this Makefile from the sim/ directory:  <repo>/sim/Makefile
# library name
work= work
RTL= ../rtl/*
SVTB1= ../tb/mod12_top.sv
INC = +incdir+../tb +incdir+../agt_top +incdir+../rtl
SVTB2 = ../tb/mod12_test_pkg.sv

# test names (class names in tb/mod12_test_lib.sv)
TEST0 = mod12_rand_test
TEST1 = mod12_rst_test
TEST2 = mod12_count_up_test
TEST3 = mod12_count_dwn_test

VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

# VCS coverage metrics
VCSCOV = -cm line+cond+fsm+tgl+branch+assert


help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                  								!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.  						!"
	@echo "! sv_cmp    	=>  Create library and compile the code.           						!"
	@echo "! run_test	=>  clean, compile & run the simulation for mod12_rand_test in batch mode.			!"
	@echo "! run_test1	=>  run the simulation for mod12_rst_test in batch mode.					!"
	@echo "! run_test2	=>  run the simulation for mod12_count_up_test in batch mode.					!"
	@echo "! run_test3	=>  run the simulation for mod12_count_dwn_test in batch mode.					!"
	@echo "! view_wave1 =>  To view the waveform of mod12_rand_test	    						!"
	@echo "! view_wave2 =>  To view the waveform of mod12_rst_test	    						!"
	@echo "! view_wave3 =>  To view the waveform of mod12_count_up_test 	  						!"
	@echo "! view_wave4 =>  To view the waveform of mod12_count_dwn_test    						!"
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    				!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.							!"
	@echo "! (simulator : SIMULATOR = $(SIMULATOR), change it at the top of this file or use make <target> SIMULATOR=VCS)	!"
	@echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.mod12_top +UVM_TESTNAME=$(TEST0)
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.mod12_top +UVM_TESTNAME=$(TEST1)
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test2_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.mod12_top +UVM_TESTNAME=$(TEST2)
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test3_Questa:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.mod12_top +UVM_TESTNAME=$(TEST3)
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

view_wave1_Questa:
	vsim -view wave_file1.wlf

view_wave2_Questa:
	vsim -view wave_file2.wlf

view_wave3_Questa:
	vsim -view wave_file3.wlf

view_wave4_Questa:
	vsim -view wave_file4.wlf

report_Questa:
	vcover merge mem_cov mem_cov1 mem_cov2 mem_cov3 mem_cov4
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress_Questa: clean_Questa run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa report_Questa cov_Questa

cov_Questa:
	firefox covhtmlreport/index.html&

clean_Questa:
	rm -rf transcript* *log* fcover* covhtml* mem_cov* *.wlf modelsim.ini work

# ----------------------------- End of Definitions for Mentor's Questa Specific Targets -------------------------------#

# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
	vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca $(VCSCOV) -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_VCS:	clean  sv_cmp_VCS
	@printf 'fsdbDumpfile wave1.fsdb\nfsdbDumpvars 0 mod12_top\nrun\nexit\n' > dump1.tcl
	./simv -l test1.log -ucli -do dump1.tcl $(VCSCOV) -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=$(TEST0)
	urg -dir mem_cov1.vdb -format both -report urgReport1

run_test1_VCS:
	@printf 'fsdbDumpfile wave2.fsdb\nfsdbDumpvars 0 mod12_top\nrun\nexit\n' > dump2.tcl
	./simv -l test2.log -ucli -do dump2.tcl $(VCSCOV) -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=$(TEST1)
	urg -dir mem_cov2.vdb -format both -report urgReport2

run_test2_VCS:
	@printf 'fsdbDumpfile wave3.fsdb\nfsdbDumpvars 0 mod12_top\nrun\nexit\n' > dump3.tcl
	./simv -l test3.log -ucli -do dump3.tcl $(VCSCOV) -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=$(TEST2)
	urg -dir mem_cov3.vdb -format both -report urgReport3

run_test3_VCS:
	@printf 'fsdbDumpfile wave4.fsdb\nfsdbDumpvars 0 mod12_top\nrun\nexit\n' > dump4.tcl
	./simv -l test4.log -ucli -do dump4.tcl $(VCSCOV) -cm_dir ./mem_cov4 +ntb_random_seed_automatic +UVM_TESTNAME=$(TEST3)
	urg -dir mem_cov4.vdb -format both -report urgReport4

view_wave1_VCS:
	verdi -ssf wave1.fsdb

view_wave2_VCS:
	verdi -ssf wave2.fsdb

view_wave3_VCS:
	verdi -ssf wave3.fsdb

view_wave4_VCS:
	verdi -ssf wave4.fsdb

report_VCS:
	urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS report_VCS

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi* dump*.tcl merged_dir* DVEfiles

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#
