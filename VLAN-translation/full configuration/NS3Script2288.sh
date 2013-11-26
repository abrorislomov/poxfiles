#include <ctype.h>
#include <iostream>
#include <fstream>
#include <string>
#include <cassert>

#include "ns3/core-module.h"
#include "ns3/simulator-module.h"
#include "ns3/node-module.h"
#include "ns3/helper-module.h"

using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("FirstScriptExample");

NodeContainer h2;
h2.Create (X);
NodeContainer h3;
h3.Create (X);
NodeContainer h4;
h4.Create (X);
NodeContainer h5;
h5.Create (X);
NodeContainer s6;
s6.Create (X);
NodeContainer s7;
s7.Create (X);
NodeContainer s8;
s8.Create (X);

//Addressing...
Ipv4AddressHelper ipv4;
ipv4.SetBase ("10.0.0.2", "255.255.255.0");
ipv4.Assign (h2);
ipv4.SetBase ("10.0.0.3", "255.255.255.0");
ipv4.Assign (h3);
ipv4.SetBase ("10.0.0.4", "255.255.255.0");
ipv4.Assign (h4);
ipv4.SetBase ("10.0.0.5", "255.255.255.0");
ipv4.Assign (h5);

###################################################################
//Do you want to contribute for development of automatic NS3 code? Please contact me via email: ramonreisfontes@gmail.com
###################################################################
