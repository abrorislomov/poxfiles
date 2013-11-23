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
switch0 = 0000000000000003
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 2
# ACTIONS---------------------------------
flow0vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow0out = of.ofp_action_output (port = 1)
flow0msg.actions = [flow0vlan_id, flow0out] 

#flow2: 
switch1 = 0000000000000003
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 1
flow1msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow1stripvlan = of.ofp_action_strip_vlan () 
flow1out = of.ofp_action_output (port = 2)
flow1msg.actions = [flow1stripvlan, flow1out] 

#flow3: 
switch2 = 0000000000000004
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 1
flow2msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow2stripvlan = of.ofp_action_strip_vlan () 
flow2out = of.ofp_action_output (port = 2)
flow2msg.actions = [flow2stripvlan, flow2out] 

#flow4: 
switch3 = 0000000000000004
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 2
# ACTIONS---------------------------------
flow3vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow3out = of.ofp_action_output (port = 1)
flow3msg.actions = [flow3vlan_id, flow3out] 

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
