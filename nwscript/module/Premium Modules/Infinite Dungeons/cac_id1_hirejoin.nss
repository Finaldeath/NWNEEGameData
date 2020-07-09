#include "x0_i0_henchman"
#include "inc_id1_utility"

void main()
{
    // make it so the follower will never respawn
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    SetLocalInt(oDungeon, "b" + sVariable + "Dead", TRUE);

    object oPC = GetPCSpeaker();
    object oHireling = OBJECT_SELF;

    SetLocalInt(oHireling, "bFollower", TRUE);

    AddHenchman(oPC, oHireling);
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    SetLocalString(oHireling, "sConversation", "id1_follower");
}
