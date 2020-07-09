// B W-Husey
// September 2005
// This script used in the rumours dialogue if the PC tries to bribe the NPC, and checks
// the NPCs general disposition based on the PC's charisma. It is the same as the initial check, though
// if the end result is a failure, that's it for trying to get a rumour out of this NPC.

void main()
{
    object oPC = GetPCSpeaker();
    int nBase = GetAbilityScore(oPC, ABILITY_CHARISMA) + GetAbilityModifier( ABILITY_CHARISMA,oPC);
    //The PC's chance of a favourable response = charisma + charisma modifier (i.e. easy for high charisma characters)
    //The PC rolls a d20 and deducts it from nBase to pass. A score above 0 gets a rumour, else that's it for this NPC.
    int nResult = nBase-d20();
    if (nResult>0)
    {
    SendMessageToPC(oPC,"Charisma check passed");
    GiveXPToCreature(oPC,20);
    SetLocalInt(OBJECT_SELF,"nMyRumour",0);
    }
    else if (nResult<1)
    {
    SendMessageToPC(oPC,"Charisma check failed");
    SetLocalInt(OBJECT_SELF,"nMyRumour",51); //This NPC is in a state where he will never give a rumour.
    }
}
