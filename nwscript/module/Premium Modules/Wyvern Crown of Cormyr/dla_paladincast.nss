// the henchman casts their spell

void main()
{
    int nSpell = GetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast");
    object oTarget = GetLocalObject(OBJECT_SELF, "Henchman_Spell_Target");

    //start debug
    /*
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        SendMessageToPC(oPC, "Spell ref is "+IntToString(nSpell));
        SendMessageToPC(oPC, "Target is "+ GetName(oTarget));
        oPC = GetNextPC();
    }
    */
    if ((nSpell > 0) && (GetIsObjectValid(oTarget)))
    {
        ClearAllActions();
        ActionCastSpellAtObject(nSpell, oTarget, METAMAGIC_NONE, TRUE);
        ActionDoCommand(SetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast", 0));
        ActionDoCommand(SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID));
        DecrementRemainingSpellUses(OBJECT_SELF, nSpell);
    }
    else PlayVoiceChat(VOICE_CHAT_CUSS);
}
