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
switch0 = 0000000000000006
flow0msg = of.ofp_flow_mod() 
flow0msg.cookie = 0 
flow0msg.priority = 32768
flow0msg.match.in_port = 1
flow0msg.match.nw_dst = IPAddr("10.0.0.5")
flow0msg.match.tp_dst = 80
# ACTIONS---------------------------------
flow0out = of.ofp_action_output (port = 3)
flow0dstPort = ofp_action_tp_port.set_dst = (tp_port = 80)
flow0srcMAC = ofp_action_dl_addr.set_src(EthAddr("00:00:00:00:00:06"))
flow0srcIP = ofp_action_nw_addr.set_src(IPAddr("10.0.0.1"))
flow0dstIP = ofp_action_nw_addr.set_dst(IPAddr("10.0.0.5"))
flow0msg.actions = [flow0srcPort, flow0srcIP, flow0srcIP, flow0srcMAC, flow0out] 

#flow1: 
switch1 = 0000000000000006
flow1msg = of.ofp_flow_mod() 
flow1msg.cookie = 0 
flow1msg.priority = 32768
flow1msg.match.in_port = 1
flow1msg.match.nw_dst = IPAddr("10.0.0.4")
flow1msg.match.tp_dst = 80
# ACTIONS---------------------------------
flow1vlan_id = of.ofp_action_vlan_vid (vlan_vid = 20)
flow1out = of.ofp_action_output (port = 2)
flow1dstPort = ofp_action_tp_port.set_dst = (tp_port = 80)
flow1srcMAC = ofp_action_dl_addr.set_src(EthAddr("00:00:00:00:00:06"))
flow1srcIP = ofp_action_nw_addr.set_src(IPAddr("10.0.0.1"))
flow1dstIP = ofp_action_nw_addr.set_dst(IPAddr("10.0.0.4"))
flow1msg.actions = [flow1vlan_id, flow1srcPort, flow1srcIP, flow1srcIP, flow1srcMAC, flow1out] 

#flow2: 
switch2 = 0000000000000006
flow2msg = of.ofp_flow_mod() 
flow2msg.cookie = 0 
flow2msg.priority = 32768
flow2msg.match.in_port = 3
flow2msg.match.nw_src = IPAddr("10.0.0.5")
# ACTIONS---------------------------------
flow2out = of.ofp_action_output (port = 1)
flow2srcIP = ofp_action_nw_addr.set_src(IPAddr("10.0.0.1"))
flow2msg.actions = [flow2srcIP, flow2out] 

#flow3: 
switch3 = 0000000000000006
flow3msg = of.ofp_flow_mod() 
flow3msg.cookie = 0 
flow3msg.priority = 32768
flow3msg.match.in_port = 2
flow3msg.match.nw_src = IPAddr("10.0.0.4")
# ACTIONS---------------------------------
flow3out = of.ofp_action_output (port = 1)
flow3srcIP = ofp_action_nw_addr.set_src(IPAddr("10.0.0.1"))
flow3msg.actions = [flow3srcIP, flow3out] 

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
