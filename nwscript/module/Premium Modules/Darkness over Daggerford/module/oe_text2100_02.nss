#include "hf_in_npc"

void main()
{
    object oPC = GetEnteringObject();

    if (!(GetIsPC(oPC))) return;
    if (GetLocalInt(OBJECT_SELF,"fired")==1) return;

    if (GetLocalInt(GetModule(), "hevesar_plot") ==5)
    {
        TeleportToMapLocation(oPC, GetLocation(oPC));
        SetLocalInt(OBJECT_SELF,"fired",1);
        AssignCommand(oPC, SpeakString("A ship has weighed anchor here. The name is 'The Barracuda'."));
    }
}
