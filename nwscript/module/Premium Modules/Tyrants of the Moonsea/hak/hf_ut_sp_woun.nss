// set and cast the current spell

#include "hf_in_spellcheck"

void main()
{
    int nSpell = SPELL_WOUNDING_WHISPERS;

    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    SpellSetSpellNum(oPC, oNPC, nSpell);
    SpellCastSpell(oPC, oNPC, nSpell);
}
