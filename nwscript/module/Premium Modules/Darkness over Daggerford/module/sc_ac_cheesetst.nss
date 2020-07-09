//Filename: sc_ac_cheesetst
//This checks to see if the PC has tasted Churlgo Cheese.
//Author: Alan Tarrant
//12/10/05
//
int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"ac_taste_cheese")==1)
    return TRUE;
    return FALSE;
}
