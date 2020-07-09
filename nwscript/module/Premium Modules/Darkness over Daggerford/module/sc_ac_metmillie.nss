//Filename: sc_ac_metmillie
//This checks to see if the PC has met Millie Churlgo.
//Author: Alan Tarrant
//12/10/05
//
int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"ac_met_millie")==1)
    return TRUE;
    return FALSE;
}
