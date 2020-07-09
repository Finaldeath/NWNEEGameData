// the player has spoken to the slaver in common. the arena fight stops.

void main()
{
    object oPC = GetPCSpeaker();
    object oElf = GetNearestObjectByTag("ks_lizslave2", oPC);
    object oThokk = GetNearestObjectByTag("ks_lizslave1", oPC);

    // thokk and the elf stop fighting and look at the player
     if (GetIsObjectValid(oThokk))
    {
        AdjustReputation(oElf, oThokk, 50);
        ClearPersonalReputation(oElf, oThokk);
        AssignCommand(oThokk, ClearAllActions(TRUE));
        AssignCommand(oThokk, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oThokk, SpeakString("*grunt*"));
    }
    if (GetIsObjectValid(oElf))
    {
        AdjustReputation(oThokk, oElf, 50);
        ClearPersonalReputation(oThokk, oElf);
        AssignCommand(oElf, ClearAllActions(TRUE));
        AssignCommand(oElf, SetFacingPoint(GetPosition(oPC)));
        string sQuote = GetLocalString(GetModule(), "QUOTE");
        AssignCommand(oElf, SpeakString(sQuote+"Finally! Someone is talking sense around here!"+sQuote));
    }

    // the other two lizards in the room turn to face the player
    object oLizard1 = GetNearestObjectByTag("ks_lizman1", oPC, 1);
    if (GetIsObjectValid(oLizard1))
    {
        AssignCommand(oLizard1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oLizard1, SpeakString("*hiss*"));
    }
    object oLizard2 = GetNearestObjectByTag("ks_lizman1", oPC, 2);
    if (GetIsObjectValid(oLizard2))
    {
        AssignCommand(oLizard2, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oLizard2, SpeakString("*hiss*"));
    }
}
