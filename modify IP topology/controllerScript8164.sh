#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#flow1: 
switch0 = 0000000000000004
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 1
flow0msg.match.nw_dst = IPAddr("172.0.0.2")
# ACTIONS---------------------------------
flow0out = of.ofp_action_output (port = 2)
flow0srcIP = ofp_action_nw_addr.set_src(IPAddr("172.0.0.1"))
flow0msg.actions = [flow0srcIP, flow0out] 

#flow2: 
switch1 = 0000000000000004
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 2
flow1msg.match.nw_dst = IPAddr("10.0.0.2")
# ACTIONS---------------------------------
flow1out = of.ofp_action_output (port = 1)
flow1srcIP = ofp_action_nw_addr.set_src(IPAddr("10.0.0.1"))
flow1msg.actions = [flow1srcIP, flow1out] 

def install_flows(): 
   log.info("    *** Installing static flows... ***")
   # Push flows to switches
   core.openflow.sendToDPID(switch0, flow0msg)
   core.openflow.sendToDPID(switch1, flow1msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
