//::///////////////////////////////////////////////
//:: FileName at_fernigold4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/11/2005 23:00:48
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 50);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 500);
    SetLocalInt(GetPCSpeaker(), "pm_fernigoldmet", 2);
    //set variable for towncrier
    SetLocalInt(GetModule(), "pm_fernigoldreturn", 1);

}
