#!/usr/bin/python

"""
Script created by VND - Visual Network Description
"""
from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSKernelSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.link import Link, TCLink

def topology():
    "Create a network."
    net = Mininet( controller=RemoteController, link=TCLink, switch=OVSKernelSwitch )

    print "*** Creating nodes"
    h1 = net.addHost( 'h1', mac='00:00:00:00:00:01', ip='10.0.0.1/24' )
    h2 = net.addHost( 'h2', mac='00:00:00:00:00:02', ip='10.0.0.2/24' )
    h3 = net.addHost( 'h3', mac='00:00:00:00:00:03', ip='10.0.0.3/24' )
    h4 = net.addHost( 'h4', mac='00:00:00:00:00:04', ip='10.0.0.4/24' )
    h5 = net.addHost( 'h5', mac='00:00:00:00:00:05', ip='10.0.0.5/24' )
    h6 = net.addHost( 'h6', mac='00:00:00:00:00:06', ip='10.0.0.6/24' )
    s8 = net.addSwitch( 's8' )
    s9 = net.addSwitch( 's9' )
    s10 = net.addSwitch( 's10' )
    c11 = net.addController( 'c11', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print "*** Creating links"
    net.addLink(s9, h6, 4, 0)
    net.addLink(s9, h5, 3, 0)
    net.addLink(s9, h4, 2, 0)
    net.addLink(s10, s9, 2, 1)
    net.addLink(s8, s10, 4, 1)
    net.addLink(h3, s8, 0, 3)
    net.addLink(h2, s8, 0, 2)
    net.addLink(h1, s8, 0, 1)

    print "*** Starting network"
    net.build()
    s10.start( [c11] )
    s9.start( [c11] )
    s8.start( [c11] )
    c11.start()

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

