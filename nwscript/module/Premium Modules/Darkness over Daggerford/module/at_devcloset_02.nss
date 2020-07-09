// the player casts dispel magic at the closet

void main()
{
    object oPC = GetPCSpeaker();

    ActionPauseConversation();
    ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, OBJECT_SELF);
    ActionResumeConversation();
}
