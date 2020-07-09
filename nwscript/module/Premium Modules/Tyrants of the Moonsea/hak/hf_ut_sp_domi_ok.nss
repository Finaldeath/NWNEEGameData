// returns false if the PC does not have the spell learned

#include "hf_in_spellcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nSpell = SPELL_DOMINATE_PERSON;

    return(SpellCanCast(oPC, nSpell));
}
