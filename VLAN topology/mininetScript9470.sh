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
    h1 = net.addHost( 'h1', mac='00:00:00:00:00:01', ip='10.0.0.1/8' )
    h2 = net.addHost( 'h2', mac='00:00:00:00:00:02', ip='10.0.0.2/8' )
    s3 = net.addSwitch( 's3' )
    s4 = net.addSwitch( 's4' )
    c5 = net.addController( 'c5', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print "*** Creating links"
    net.addLink(h2, s4, 0, 2)
    net.addLink(h1, s3, 0, 2)
    net.addLink(s3, s4, 1, 1)

    print "*** Starting network"
    net.build()
    s4.start( [c5] )
    s3.start( [c5] )
    c5.start()

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

