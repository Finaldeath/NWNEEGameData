//::///////////////////////////////////////////////
//:: FileName con_ac_sejbandit
//:: Set player to have heard talk of bandits in Gillian's Hill.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 12/31/2005 4:47:28 PM
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "ac_sej_bandit")> 0) return;
    SetLocalInt(oPC, "ac_sej_bandit", 1);

}
