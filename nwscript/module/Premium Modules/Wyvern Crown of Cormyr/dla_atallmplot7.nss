//DEBUG ONLY - MODIFY ME FOR USE

// October 2005
// B W-Husey
// Sets the main plot variable to 7.

#include "cu_functions"
#include "dla_i0_joust"
void main()
{
object oPC = GetPCSpeaker();

string sName = "MP7"+GetTag(OBJECT_SELF);

if (GetLocalInt(oPC,sName)<1) //once only
    {
    AllParty("nMainPlot",oPC,7);
    DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_DONE);//set to 2nd tourney
    DLA_SetJoustState(oPC, DLA_JOUSTSTATE_T1_2);
    }

}







