//Blizzard casts Invisibility Sphere on those present

void main()
{
    ActionPauseConversation();
    ActionCastSpellAtObject(SPELL_INVISIBILITY_SPHERE, OBJECT_SELF, METAMAGIC_ANY, TRUE);
    ActionResumeConversation();
}
