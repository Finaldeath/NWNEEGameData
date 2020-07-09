// B W-Husey
// December 2005
// Hawklin's plot variable used in section 4 of the module (see plot variable doc) is set to 3
// The PC has shared info on Salvatori's piracy.Piracy quest variable set to 2.
#include "cu_functions"

void main()
{
    AllParty("nHawklinPlot2",GetPCSpeaker(),3);
    AllParty("nPiracy",GetPCSpeaker(),2);
}
