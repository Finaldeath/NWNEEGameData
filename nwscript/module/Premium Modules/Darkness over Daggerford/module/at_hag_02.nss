// end the hag quest

#include "hf_in_plot"
#include "hf_in_xp"

// returns true if the lizardfolk shaman in AR1901 is dead
int IsShamanDead()
{
    object oShaman = GetObjectByTag("ks_lizshaman");
    if (!GetIsObjectValid(oShaman))
    {
        return(TRUE);
    }
    return(GetIsDead(oShaman));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oDoll  = GetItemPossessedBy(oPC, "ks_hagdoll");
    object oKnife = GetItemPossessedBy(oPC, "ks_lizknife");
    object oBrush = GetItemPossessedBy(oPC, "ks_lizbrooch");
    float fXP = 100.0;

    // if no brush was found, XP penalty
    if (!GetIsObjectValid(oBrush))
    {
        fXP -= 25.0;
    }

    // if the shaman is dead, XP penalty
    if (IsShamanDead())
    {
        fXP -= 25.0;
    }

    // the effigy must be given to the hag
    DestroyObject(oDoll);

    // the player might decide to keep the knife
    // .. it is mildly useful
    if (GetLocalInt(OBJECT_SELF, "HF_ARG") > 0)
    {
        DestroyObject(oKnife);
    }

    // give the brush to the hag; the player might have chosen
    // .. to keep it (lied to the hag) but the brush is useless
    // .. so might as well get rid of it
    DestroyObject(oBrush);

    // give XP and update journal
    PlotLevelSet("ks_greenhag", 3);
    AddJournalQuestEntry("j87", 2, oPC);
    GiveQuestXPToCreature(oPC, "j87", fXP);
}
