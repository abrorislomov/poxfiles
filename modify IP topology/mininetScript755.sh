#!/usr/bin/python

"""
Script created by VND - Visual Network Description
"""
from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSKernelSwitch, IVSSwitch, OVSLegacyKernelSwitch, UserSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.link import Link, TCLink

def topology():
    "Create a network."
    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch )

    print "*** Creating nodes"
    h1 = net.addHost( 'h1', mac='00:00:00:00:00:01', ip='10.0.0.1/24' )
    h2 = net.addHost( 'h2', mac='00:00:00:00:00:02', ip='172.0.0.1/24' )
    c3 = net.addController( 'c3', controller=RemoteController, ip='127.0.0.1', port=6633 )
    s4 = net.addSwitch( 's4' )

    print "*** Creating links"
    net.addLink(s4, h2, 2, 0)
    net.addLink(h1, s4, 0, 1)

    print "*** Starting network"
    net.build()
    s4.start( [c3] )
    c3.start()

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

