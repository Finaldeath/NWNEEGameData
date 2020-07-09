//::///////////////////////////////////////////////
//:: FileName con_ac_pickpockd
//:: Take gold from player (pickpocketed) and set met variable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:22:44 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC);
    if (nGold >= 5)
        nGold = 5;
    TakeGoldFromCreature(nGold,oPC);
    SetLocalInt(OBJECT_SELF,"has_met_pc",1);
}
