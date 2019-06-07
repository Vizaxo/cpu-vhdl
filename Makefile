test: logic.vhd logicn.vhd testbench.vhd
	nvc -a logic.vhd logicn.vhd testbench.vhd -e test_all -r
