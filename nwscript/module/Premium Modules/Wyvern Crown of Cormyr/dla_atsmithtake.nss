/*
    DLA_ATSMITHTAKE.nss
    gaoneng erick
    may 12, 2005

    takes gold and items now
*/
void main()
{
    object self = OBJECT_SELF;
    int appear, spell = GetLastSpell();
    switch (spell)
    {
        case SPELL_HEAL : appear = APPEARANCE_TYPE_KOBOLD_B ; break;
        case SPELL_CURE_CRITICAL_WOUNDS : appear = APPEARANCE_TYPE_GOBLIN_B ; break;
        case SPELL_CURE_LIGHT_WOUNDS : appear = APPEARANCE_TYPE_KID_FEMALE ; break;
        case SPELL_CURE_MODERATE_WOUNDS : appear = APPEARANCE_TYPE_IMP ; break;
        default : appear = 0 ; break;
    }
    if (appear)
    {
        SetCreatureAppearanceType(self, appear);
        ActionRandomWalk();
    }
}
