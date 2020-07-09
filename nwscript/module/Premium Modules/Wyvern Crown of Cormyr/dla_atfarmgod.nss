// February 2006
// B W-Husey
// Give the PC back his henchmen (removed so they don't interfere with cutscene)

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    object oGodfroy = GetNearestObjectByTag("Godfroy");
    SetDidQuit(oPC, oGodfroy, FALSE);

    DLA_SetHenchman(oGodfroy, oPC); //Don't seem to be able to trust this function

}



