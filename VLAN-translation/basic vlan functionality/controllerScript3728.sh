#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#SW1_VLAN10: 
switch0 = 0000000000000007
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 2
flow0msg.match.nw_dst = IPAddr("10.0.0.5")
# ACTIONS---------------------------------
flow0vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow0out = of.ofp_action_output (port = 4)
flow0msg.actions = [flow0vlan_id, flow0out] 

#SW1_VLAN10-reverse: 
switch1 = 0000000000000007
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 4
flow1msg.match.nw_dst = IPAddr("10.0.0.2")
flow1msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow1stripvlan = of.ofp_action_strip_vlan () 
flow1out = of.ofp_action_output (port = 2)
flow1msg.actions = [flow1stripvlan, flow1out] 

#SW2_VLAN10: 
switch2 = 0000000000000008
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 3
flow2msg.match.nw_dst = IPAddr("10.0.0.2")
# ACTIONS---------------------------------
flow2vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow2out = of.ofp_action_output (port = 1)
flow2msg.actions = [flow2vlan_id, flow2out] 

#SW2_VLAN10-reverse: 
switch3 = 0000000000000008
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 1
flow3msg.match.nw_dst = IPAddr("10.0.0.5")
flow3msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow3stripvlan = of.ofp_action_strip_vlan () 
flow3out = of.ofp_action_output (port = 3)
flow3msg.actions = [flow3stripvlan, flow3out] 

#SW1_VLAN20: 
switch4 = 0000000000000007
flow4msg = of.ofp_flow_mod() 
flow4msg.cookie = 0 
flow4msg.priority = 32768
flow4msg.match.in_port = 3
flow4msg.match.nw_dst = IPAddr("10.0.0.4")
# ACTIONS---------------------------------
flow4vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow4out = of.ofp_action_output (port = 4)
flow4msg.actions = [flow4vlan_id, flow4out] 

#SW1_VLAN20-reverse: 
switch5 = 0000000000000007
flow5msg = of.ofp_flow_mod() 
flow5msg.cookie = 0 
flow5msg.priority = 32768
flow5msg.match.in_port = 4
flow5msg.match.nw_dst = IPAddr("10.0.0.3")
flow5msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow5stripvlan = of.ofp_action_strip_vlan () 
flow5out = of.ofp_action_output (port = 3)
flow5msg.actions = [flow5stripvlan, flow5out] 

#SW2_VLAN20: 
switch6 = 0000000000000008
flow6msg = of.ofp_flow_mod() 
flow6msg.cookie = 0 
flow6msg.priority = 32768
flow6msg.match.in_port = 2
flow6msg.match.nw_dst = IPAddr("10.0.0.3")
# ACTIONS---------------------------------
flow6vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow6out = of.ofp_action_output (port = 1)
flow6msg.actions = [flow6vlan_id, flow6out] 

#SW2_VLAN20-reverse: 
switch7 = 0000000000000008
flow7msg = of.ofp_flow_mod() 
flow7msg.cookie = 0 
flow7msg.priority = 32768
flow7msg.match.in_port = 1
flow7msg.match.nw_dst = IPAddr("10.0.0.4")
flow7msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow7stripvlan = of.ofp_action_strip_vlan () 
flow7out = of.ofp_action_output (port = 2)
flow7msg.actions = [flow7stripvlan, flow7out] 

def install_flows(): 
   log.info("    *** Installing static flows... ***")
   # Push flows to switches
   core.openflow.sendToDPID(switch0, flow0msg)
   core.openflow.sendToDPID(switch1, flow1msg)
   core.openflow.sendToDPID(switch2, flow2msg)
   core.openflow.sendToDPID(switch3, flow3msg)
   core.openflow.sendToDPID(switch4, flow4msg)
   core.openflow.sendToDPID(switch5, flow5msg)
   core.openflow.sendToDPID(switch6, flow6msg)
   core.openflow.sendToDPID(switch7, flow7msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
