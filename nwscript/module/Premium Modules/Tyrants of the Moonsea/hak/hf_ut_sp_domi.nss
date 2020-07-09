// set and cast the current spell

#include "hf_in_spellcheck"

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nSpell = SPELL_DOMINATE_PERSON;                             ;

    SpellSetSpellNum(oPC, oNPC, nSpell);
    SpellCastSpell(oPC, oNPC, nSpell);
}
