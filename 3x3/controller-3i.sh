#!/usr/bin/python
"""
#Script created by VND - Visual Network Description 
"""
from pox.core import core
from pox.lib.addresses import IPAddr
from pox.lib.addresses import EthAddr
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

#vlan10-1: 
switch0 = 0000000000000008
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 1
flow0msg.match.nw_dst = IPAddr("10.0.0.4")
# ACTIONS---------------------------------
flow0vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow0out = of.ofp_action_output (port = 4)
flow0msg.actions = [flow0vlan_id, flow0out] 

#vlan20-1: 
switch1 = 0000000000000008
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 2
flow1msg.match.nw_dst = IPAddr("10.0.0.5")
# ACTIONS---------------------------------
flow1vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow1out = of.ofp_action_output (port = 4)
flow1msg.actions = [flow1vlan_id, flow1out] 

#vlan30-1: 
switch2 = 0000000000000008
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 3
flow2msg.match.nw_dst = IPAddr("10.0.0.6")
# ACTIONS---------------------------------
flow2vlan_id = of.ofp_action_vlan_vid (vlan_vid = 30)
flow2out = of.ofp_action_output (port = 4)
flow2msg.actions = [flow2vlan_id, flow2out] 

#vlan10-1-in: 
switch3 = 0000000000000008
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 4
flow3msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow3stripvlan = of.ofp_action_strip_vlan () 
flow3out = of.ofp_action_output (port = 1)
flow3msg.actions = [flow3stripvlan, flow3out] 

#vlan20-1-in: 
switch4 = 0000000000000008
flow4msg = of.ofp_flow_mod() 
flow4msg.cookie = 0 
flow4msg.priority = 32768
flow4msg.match.in_port = 4
flow4msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow4stripvlan = of.ofp_action_strip_vlan () 
flow4out = of.ofp_action_output (port = 2)
flow4msg.actions = [flow4stripvlan, flow4out] 

#vlan30-1-in: 
switch5 = 0000000000000008
flow5msg = of.ofp_flow_mod() 
flow5msg.cookie = 0 
flow5msg.priority = 32768
flow5msg.match.in_port = 4
flow5msg.match.dl_vlan = 30
# ACTIONS---------------------------------
flow5stripvlan = of.ofp_action_strip_vlan () 
flow5out = of.ofp_action_output (port = 3)
flow5msg.actions = [flow5stripvlan, flow5out] 

#vlan10-2: 
switch6 = 0000000000000009
flow6msg = of.ofp_flow_mod() 
flow6msg.cookie = 0 
flow6msg.priority = 32768
flow6msg.match.in_port = 2
flow6msg.match.nw_dst = IPAddr("10.0.0.1")
# ACTIONS---------------------------------
flow6vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow6out = of.ofp_action_output (port = 1)
flow6msg.actions = [flow6vlan_id, flow6out] 

#vlan20-2: 
switch7 = 0000000000000009
flow7msg = of.ofp_flow_mod() 
flow7msg.cookie = 0 
flow7msg.priority = 32768
flow7msg.match.in_port = 3
flow7msg.match.nw_dst = IPAddr("10.0.0.2")
# ACTIONS---------------------------------
flow7vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow7out = of.ofp_action_output (port = 1)
flow7msg.actions = [flow7vlan_id, flow7out] 

#vlan30-2: 
switch8 = 0000000000000009
flow8msg = of.ofp_flow_mod() 
flow8msg.cookie = 0 
flow8msg.priority = 32768
flow8msg.match.in_port = 4
flow8msg.match.nw_dst = IPAddr("10.0.0.3")
# ACTIONS---------------------------------
flow8vlan_id = of.ofp_action_vlan_vid (vlan_vid = 30)
flow8out = of.ofp_action_output (port = 1)
flow8msg.actions = [flow8vlan_id, flow8out] 

#vlan10-2-in: 
switch9 = 0000000000000009
flow9msg = of.ofp_flow_mod() 
flow9msg.cookie = 0 
flow9msg.priority = 32768
flow9msg.match.in_port = 1
flow9msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow9stripvlan = of.ofp_action_strip_vlan () 
flow9out = of.ofp_action_output (port = 2)
flow9msg.actions = [flow9stripvlan, flow9out] 

#vlan20-2-in: 
switch10 = 0000000000000009
flow10msg = of.ofp_flow_mod() 
flow10msg.cookie = 0 
flow10msg.priority = 32768
flow10msg.match.in_port = 1
flow10msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow10stripvlan = of.ofp_action_strip_vlan () 
flow10out = of.ofp_action_output (port = 3)
flow10msg.actions = [flow10stripvlan, flow10out] 

#vlan30-2-in: 
switch11 = 0000000000000009
flow11msg = of.ofp_flow_mod() 
flow11msg.cookie = 0 
flow11msg.priority = 32768
flow11msg.match.in_port = 1
flow11msg.match.dl_vlan = 30
# ACTIONS---------------------------------
flow11stripvlan = of.ofp_action_strip_vlan () 
flow11out = of.ofp_action_output (port = 4)
flow11msg.actions = [flow11stripvlan, flow11out] 

#vlan-translation: 
switch12 = 0000000000000010
flow12msg = of.ofp_flow_mod() 
flow12msg.cookie = 0 
flow12msg.priority = 32768
flow12msg.match.in_port = 1
flow12msg.match.nw_dst = IPAddr("10.0.0.5")
# ACTIONS---------------------------------
flow12vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow12out = of.ofp_action_output (port = 2)
flow12msg.actions = [flow12vlan_id, flow12out] 

#bridge-in: 
switch13 = 0000000000000010
flow13msg = of.ofp_flow_mod() 
flow13msg.cookie = 0 
flow13msg.priority = 32768
flow13msg.match.in_port = 1
# ACTIONS---------------------------------
flow13out = of.ofp_action_output (port = 2)
flow13msg.actions = [flow13out] 

#bridge-out: 
switch14 = 0000000000000010
flow14msg = of.ofp_flow_mod() 
flow14msg.cookie = 0 
flow14msg.priority = 32768
flow14msg.match.in_port = 2
# ACTIONS---------------------------------
flow14out = of.ofp_action_output (port = 1)
flow14msg.actions = [flow14out] 

#vlan-translation-out-1: 
switch15 = 0000000000000010
flow15msg = of.ofp_flow_mod() 
flow15msg.cookie = 0 
flow15msg.priority = 32768
flow15msg.match.in_port = 2
flow15msg.match.nw_dst = IPAddr("10.0.0.1")
flow15msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow15vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow15out = of.ofp_action_output (port = 1)
flow15msg.actions = [flow15vlan_id, flow15out] 

#vlan-translation-out-2: 
switch16 = 0000000000000010
flow16msg = of.ofp_flow_mod() 
flow16msg.cookie = 0 
flow16msg.priority = 32768
flow16msg.match.in_port = 2
flow16msg.match.nw_dst = IPAddr("10.0.0.3")
flow16msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow16vlan_id = of.ofp_action_vlan_vid (vlan_vid = 30)
flow16out = of.ofp_action_output (port = 1)
flow16msg.actions = [flow16vlan_id, flow16out] 

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
   core.openflow.sendToDPID(switch10, flow10msg)
   core.openflow.sendToDPID(switch11, flow11msg)
   core.openflow.sendToDPID(switch12, flow12msg)
   core.openflow.sendToDPID(switch13, flow13msg)
   core.openflow.sendToDPID(switch14, flow14msg)
   core.openflow.sendToDPID(switch15, flow15msg)
   core.openflow.sendToDPID(switch16, flow16msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
