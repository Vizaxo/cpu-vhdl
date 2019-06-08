test: logic.vhd logicn.vhd logic-multi-way.vhd testbench.vhd
	nvc -a logic.vhd logicn.vhd logic-multi-way.vhd testbench.vhd -e test_all -r
