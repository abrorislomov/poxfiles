#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#vlan10-out: 
switch0 = 0000000000000001
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
# ACTIONS---------------------------------
flow0vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow0msg.actions = [flow0vlan_id] 

#vlan10-in-1: 
switch1 = 0000000000000001
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 4
flow1msg.match.nw_dst = IPAddr("10.0.0.1")
flow1msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow1stripvlan = of.ofp_action_strip_vlan () 
flow1out = of.ofp_action_output (port = 1)
flow1msg.actions = [flow1stripvlan, flow1out] 

#vlan10-in-2: 
switch2 = 0000000000000001
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 4
flow2msg.match.nw_dst = IPAddr("10.0.0.2")
flow2msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow2stripvlan = of.ofp_action_strip_vlan () 
flow2out = of.ofp_action_output (port = 2)
flow2msg.actions = [flow2stripvlan, flow2out] 

#vlan10-in-3: 
switch3 = 0000000000000001
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 4
flow3msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow3stripvlan = of.ofp_action_strip_vlan () 
flow3out = of.ofp_action_output (port = 3)
flow3msg.actions = [flow3stripvlan, flow3out] 

#vlan20-out: 
switch4 = 0000000000000002
flow4msg = of.ofp_flow_mod() 
flow4msg.cookie = 0 
flow4msg.priority = 32768
# ACTIONS---------------------------------
flow4vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow4msg.actions = [flow4vlan_id] 

#vlan20-in-1: 
switch5 = 0000000000000002
flow5msg = of.ofp_flow_mod() 
flow5msg.cookie = 0 
flow5msg.priority = 32768
flow5msg.match.in_port = 1
flow5msg.match.nw_dst = IPAddr("10.0.0.4")
flow5msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow5stripvlan = of.ofp_action_strip_vlan () 
flow5out = of.ofp_action_output (port = 2)
flow5msg.actions = [flow5stripvlan, flow5out] 

#vlan20-in-2: 
switch6 = 0000000000000002
flow6msg = of.ofp_flow_mod() 
flow6msg.cookie = 0 
flow6msg.priority = 32768
flow6msg.match.in_port = 1
flow6msg.match.nw_dst = IPAddr("10.0.0.5")
flow6msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow6stripvlan = of.ofp_action_strip_vlan () 
flow6out = of.ofp_action_output (port = 3)
flow6msg.actions = [flow6stripvlan, flow6out] 

#vlan20-in-3: 
switch7 = 0000000000000002
flow7msg = of.ofp_flow_mod() 
flow7msg.cookie = 0 
flow7msg.priority = 3768
flow7msg.match.in_port = 1
flow7msg.match.nw_dst = IPAddr("10.0.0.6")
flow7msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow7stripvlan = of.ofp_action_strip_vlan () 
flow7out = of.ofp_action_output (port = 4)
flow7msg.actions = [flow7stripvlan, flow7out] 

#vlan-translation: 
switch8 = 0000000000000003
flow8msg = of.ofp_flow_mod() 
flow8msg.cookie = 0 
flow8msg.priority = 32768
flow8msg.match.in_port = 1
flow8msg.match.nw_dst = IPAddr("10.0.0.5")
flow8msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow8vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow8out = of.ofp_action_output (port = 2)
flow8msg.actions = [flow8vlan_id, flow8out] 

#vlan-translation-2: 
switch9 = 0000000000000003
flow9msg = of.ofp_flow_mod() 
flow9msg.cookie = 0 
flow9msg.priority = 32768
flow9msg.match.in_port = 2
flow9msg.match.nw_src = IPAddr("10.0.0.5")
flow9msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow9vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow9out = of.ofp_action_output (port = 1)
flow9msg.actions = [flow9vlan_id, flow9out] 

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
   core.openflow.sendToDPID(switch8, flow8msg)
   core.openflow.sendToDPID(switch9, flow9msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
