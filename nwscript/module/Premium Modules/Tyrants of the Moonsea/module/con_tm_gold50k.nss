//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Conversation Condition
//::////////////////////////////////////////////////////
//:: Player owns at least 50,000 gp
//::////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return (GetGold(oPC) >= 50000);
}
