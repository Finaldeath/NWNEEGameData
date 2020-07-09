//::///////////////////////////////////////////////
//:: FileName at_fernigold3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/11/2005 23:00:11
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 25);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 250);
    SetLocalInt(GetPCSpeaker(), "pm_fernigoldmet", 2);
    //set variable for towncrier
    SetLocalInt(GetModule(), "pm_fernigolddead", 1);
}
