#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#flow0: 
switch0 = 0000000000000005
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 1
# ACTIONS---------------------------------
flow0vlan_id = of.ofp_action_vlan_vid (vlan_vid = 1)
flow0msg.actions = [flow0vlan_id] 

#flow1: 
switch1 = 0000000000000005
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 2
# ACTIONS---------------------------------
flow1vlan_id = of.ofp_action_vlan_vid (vlan_vid = 2)
flow1msg.actions = [flow1vlan_id] 

#flow2: 
switch2 = 0000000000000005
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 3
# ACTIONS---------------------------------
flow2vlan_id = of.ofp_action_vlan_vid (vlan_vid = 1)
flow2msg.actions = [flow2vlan_id] 

#flow3: 
switch3 = 0000000000000005
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 4
# ACTIONS---------------------------------
flow3vlan_id = of.ofp_action_vlan_vid (vlan_vid = 2)
flow3msg.actions = [flow3vlan_id] 

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
