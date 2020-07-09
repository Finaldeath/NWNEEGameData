//Filename: sc_ac_metporto
//This checks to see if the PC has met Porto Churlgo.
//Author: Alan Tarrant
//12/10/05
//
int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"ac_met_porto")==1)
    return TRUE;
    return FALSE;
}
