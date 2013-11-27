#!/usr/bin/python

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

#s2: vlan10-out: 
switch4 = 0000000000000002
flow4msg = of.ofp_flow_mod() 
flow4msg.cookie = 0 
flow4msg.priority = 32768
flow4msg.match.in_port = 2
# ACTIONS---------------------------------
flow4vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow4out = of.ofp_action_output (port = 5)
flow4msg.actions = [flow4vlan_id, flow4out] 

#s2: vlan10-in: 
switch5 = 0000000000000002
flow5msg = of.ofp_flow_mod() 
flow5msg.cookie = 0 
flow5msg.priority = 32768
flow5msg.match.in_port = 5
flow5msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow5stripvlan = of.ofp_action_strip_vlan () 
flow5out = of.ofp_action_output (port = 2)
flow5msg.actions = [flow5stripvlan, flow5out] 

#s2: vlan20-out: 
switch6 = 0000000000000002
flow6msg = of.ofp_flow_mod() 
flow6msg.cookie = 0 
flow6msg.priority = 32768
flow6msg.match.in_port = 3
# ACTIONS---------------------------------
flow6vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow6out = of.ofp_action_output (port = 5)
flow6msg.actions = [flow6vlan_id, flow6out] 

#s2: vlan20-in: 
switch7 = 0000000000000002
flow7msg = of.ofp_flow_mod() 
flow7msg.cookie = 0 
flow7msg.priority = 32768
flow7msg.match.in_port = 5
flow7msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow7stripvlan = of.ofp_action_strip_vlan () 
flow7out = of.ofp_action_output (port = 2)
flow7msg.actions = [flow7stripvlan, flow7out] 

#s2: vlan30-out: 
switch8 = 0000000000000002
flow8msg = of.ofp_flow_mod() 
flow8msg.cookie = 0 
flow8msg.priority = 32768
flow8msg.match.in_port = 4
# ACTIONS---------------------------------
flow8vlan_id = of.ofp_action_vlan_vid (vlan_vid = 30)
flow8out = of.ofp_action_output (port = 5)
flow8msg.actions = [flow8vlan_id, flow8out] 

#s2: vlan30-in: 
switch9 = 0000000000000002
flow9msg = of.ofp_flow_mod() 
flow9msg.cookie = 0 
flow9msg.priority = 32768
flow9msg.match.in_port = 5
flow9msg.match.dl_vlan = 30
# ACTIONS---------------------------------
flow9stripvlan = of.ofp_action_strip_vlan () 
flow9out = of.ofp_action_output (port = 4)
flow9msg.actions = [flow9stripvlan, flow9out] 

#s3: vlan10-out: 
switch10 = 0000000000000003
flow10msg = of.ofp_flow_mod() 
flow10msg.cookie = 0 
flow10msg.priority = 32768
flow10msg.match.in_port = 5
# ACTIONS---------------------------------
flow10vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow10out = of.ofp_action_output (port = 1)
flow10msg.actions = [flow10vlan_id, flow10out] 

#s3: vlan10-in: 
switch11 = 0000000000000003
flow11msg = of.ofp_flow_mod() 
flow11msg.cookie = 0 
flow11msg.priority = 32768
flow11msg.match.in_port = 1
flow11msg.match.dl_vlan = 10
# ACTIONS---------------------------------
flow11stripvlan = of.ofp_action_strip_vlan () 
flow11out = of.ofp_action_output (port = 5)
flow11msg.actions = [flow11stripvlan, flow11out] 

#s3: vlan20-out: 
switch12 = 0000000000000003
flow12msg = of.ofp_flow_mod() 
flow12msg.cookie = 0 
flow12msg.priority = 32768
flow12msg.match.in_port = 6
# ACTIONS---------------------------------
flow12vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow12out = of.ofp_action_output (port = 1)
flow12msg.actions = [flow12vlan_id, flow12out] 

#s3: vlan20-in: 
switch13 = 0000000000000003
flow13msg = of.ofp_flow_mod() 
flow13msg.cookie = 0 
flow13msg.priority = 32768
flow13msg.match.in_port = 1
flow13msg.match.dl_vlan = 20
# ACTIONS---------------------------------
flow13stripvlan = of.ofp_action_strip_vlan () 
flow13out = of.ofp_action_output (port = 6)
flow13msg.actions = [flow13stripvlan, flow13out] 

#s3: vlan30-out: 
switch14 = 0000000000000003
flow14msg = of.ofp_flow_mod() 
flow14msg.cookie = 0 
flow14msg.priority = 32768
flow14msg.match.in_port = 7
# ACTIONS---------------------------------
flow14vlan_id = of.ofp_action_vlan_vid (vlan_vid = 30)
flow14out = of.ofp_action_output (port = 1)
flow14msg.actions = [flow14vlan_id, flow14out] 

#s3: vlan30-in: 
switch15 = 0000000000000003
flow15msg = of.ofp_flow_mod() 
flow15msg.cookie = 0 
flow15msg.priority = 32768
flow15msg.match.in_port = 1
flow15msg.match.dl_vlan = 30
# ACTIONS---------------------------------
flow15stripvlan = of.ofp_action_strip_vlan () 
flow15out = of.ofp_action_output (port = 7)
flow15msg.actions = [flow15stripvlan, flow15out] 

#vlan-translation-in: 
switch16 = 0000000000000002
flow16msg = of.ofp_flow_mod() 
flow16msg.cookie = 0 
flow16msg.priority = 32768
flow16msg.match.in_port = 5
flow16msg.match.nw_dst = IPAddr("10.0.0.4")
# ACTIONS---------------------------------
flow16stripvlan = of.ofp_action_strip_vlan () 
flow16out = of.ofp_action_output (port = 4)
flow16msg.actions = [flow16vlan_id, flow16stripvlan, flow16out] 

#vlans-translation-out-vlan10: 
switch17 = 0000000000000002
flow17msg = of.ofp_flow_mod() 
flow17msg.cookie = 0 
flow17msg.priority = 32768
flow17msg.match.in_port = 4
flow17msg.match.nw_dst = IPAddr("10.0.0.5")
# ACTIONS---------------------------------
flow17vlan_id = of.ofp_action_vlan_vid (vlan_vid = 10)
flow17out = of.ofp_action_output (port = 5)
flow17msg.actions = [flow17vlan_id, flow17out] 

#vlan-translation-out-vlan20: 
switch18 = 0000000000000002
flow18msg = of.ofp_flow_mod() 
flow18msg.cookie = 0 
flow18msg.priority = 32768
flow18msg.match.in_port = 4
flow18msg.match.nw_dst = IPAddr("10.0.0.6")
# ACTIONS---------------------------------
flow18vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow18out = of.ofp_action_output (port = 5)
flow18msg.actions = [flow18vlan_id, flow18out] 

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
   core.openflow.sendToDPID(switch17, flow17msg)
   core.openflow.sendToDPID(switch18, flow18msg)
   log.info("    *** Static flows installed. ***")

def launch (): 
   log.info("*** Starting... ***")
   core.callDelayed (15, install_flows)
   log.info("*** Waiting for switches to connect.. ***")
