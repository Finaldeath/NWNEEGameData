// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AligXP2"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2aLondro", oPC, "CHAOTIC", 0, 2);
    AligXP(sName, oPC, "EVIL", 25, 1);
    }
}






