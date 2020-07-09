// B W-Husey
// September 2005
// This script goes on the rumour request dialogue branch the first time the PC asks about rumours, and checks
// the NPCs general disposition based on the PC's charisma.

void main()
{
    object oPC = GetPCSpeaker();
    int nBase = GetAbilityScore(oPC, ABILITY_CHARISMA) + GetAbilityModifier( ABILITY_CHARISMA,oPC);
    //The PC's chance of a favourable response = charisma + charisma modifier (i.e. easy for high charisma characters)
    //The PC rolls a d20 and deducts it from nBase to pass. A score above 0 gets a rumour, else the PC must try another method.
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
    SetLocalInt(OBJECT_SELF,"nMyRumour",50); //This NPC is in a state where he is reluctant to give a rumour.
    }
}
