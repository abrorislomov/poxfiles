#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#s1: h1-->h4: 
switch0 = 0000000000000001
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 1
flow0msg.match.nw_dst = IPAddr("10.0.0.4")
flow0msg.match.tp_dst = 80
# ACTIONS---------------------------------
flow0out = of.ofp_action_output (port = 2)
flow0msg.actions = [flow0out] 

#s2: h1-->h4: 
switch1 = 0000000000000002
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 1
flow1msg.match.nw_dst = IPAddr("10.0.0.4")
flow1msg.match.tp_dst = 80
# ACTIONS---------------------------------
flow1out = of.ofp_action_output (port = 4)
flow1msg.actions = [flow1out] 

#s2: h4-->h1: 
switch2 = 0000000000000002
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 4
flow2msg.match.nw_dst = IPAddr("10.0.0.1")
# ACTIONS---------------------------------
flow2out = of.ofp_action_output (port = 1)
flow2msg.actions = [flow2out] 

#s1: h4-->h1: 
switch3 = 0000000000000001
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 2
flow3msg.match.nw_dst = IPAddr("10.0.0.1")
# ACTIONS---------------------------------
flow3out = of.ofp_action_output (port = 1)
flow3msg.actions = [flow3out] 

def install_flows(): 
   log.info("    *** Installing static flows... ***")
   # Push flows to switches
   core.openflow.sendToDPID(switch0, flow0msg)
   core.openflow.sendToDPID(switch1, flow1msg)
   core.openflow.sendToDPID(switch2, flow2msg)
   core.openflow.sendToDPID(switch3, flow3msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
