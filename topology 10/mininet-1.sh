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
    h7 = net.addHost( 'h7', mac='00:00:00:00:00:07', ip='10.0.0.7/24' )
    s1 = net.addSwitch( 's1' )
    s2 = net.addSwitch( 's2' )
    s3 = net.addSwitch( 's3' )
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print "*** Creating links"
    net.addLink(s3, h7, 7, 0)
    net.addLink(s3, h6, 6, 0)
    net.addLink(s3, h5, 5, 0)
    net.addLink(s2, s3, 5, 1)
    net.addLink(s2, h4, 4, 0)
    net.addLink(s2, h3, 3, 0)
    net.addLink(s2, h2, 2, 0)
    net.addLink(s1, s2, 2, 1)
    net.addLink(s1, h1, 1, 0)

    print "*** Starting network"
    net.build()
    s3.start( [c1] )
    s2.start( [c1] )
    s1.start( [c1] )
    c1.start()

    print "*** Running CLI"
    CLI( net )

    print "*** Stopping network"
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    topology()

