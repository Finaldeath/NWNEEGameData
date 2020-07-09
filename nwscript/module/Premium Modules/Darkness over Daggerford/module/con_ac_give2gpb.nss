//::///////////////////////////////////////////////
//:: FileName con_ac_give2gp
//:: Player takes 2 gp off the corpse's eyes
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/22/2006 3:23:26 AM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC, 2);
    SetLocalInt(oPC, "ac_goldeyes", 1);
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);

}
