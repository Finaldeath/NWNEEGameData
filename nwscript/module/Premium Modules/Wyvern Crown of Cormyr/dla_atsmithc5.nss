/*
    DLA_ATSMITHC.nss
    modified by : gaoneng erick
    modified on : may 11, 2006
    general cleanup
    record that player had agreed to help
*/

//October 2005
// B W-Husey
// Crafting process:
/*
Step 1  Set the cost based on the material chosen
Step 2  Record the weapon chosen
Step 3  Record how many shards
Step 4  Record which special ingredient we are using
Step 5 PC is helping ,so get his craft skill
*/

//We chose steel
void main()
{
    object oPC = GetPCSpeaker();
    int nRanks = GetSkillRank(SKILL_CRAFT_WEAPON, oPC)-5;//better be good, or it's negative
    SetLocalInt(OBJECT_SELF,"nBonus",GetLocalInt(OBJECT_SELF,"nBonus")+nRanks);
    SetLocalInt(OBJECT_SELF, "GN_PCCRAFT", TRUE);
}
