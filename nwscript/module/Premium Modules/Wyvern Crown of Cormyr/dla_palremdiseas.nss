// * use remove disease
void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetLocalObject(OBJECT_SELF, "Henchman_Spell_Target");
    ActionUseFeat(FEAT_REMOVE_DISEASE, oTarget);
    ActionDoCommand(SetLocalInt(OBJECT_SELF, "Deekin_Spell_Cast", 0));
    ActionDoCommand(SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID));
}

