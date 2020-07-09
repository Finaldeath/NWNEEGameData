// spawn horses for party members who are currently horse-less at a cost of 500GP

#include "x3_inc_horse"
#include "hf_in_plot"

// each horse costs 500 gold pieces
const int COST_PER_HORSE = 500;

// create a horse for the given player
void CreateHorse(object oPlayer, int n)
{
    object oHorse = HorseGetHorse(oPlayer);
    if (!GetIsObjectValid(oHorse))
    {
        string sWP = "WP_THAS_STABLE_HORSE" + IntToString(n);
        object oWP = GetWaypointByTag(sWP);
        oHorse = HorseCreateHorse("x3_horse001", GetLocation(oWP), oPlayer);
        if (GetIsObjectValid(oHorse))
        {
            HorseSetOwner(oHorse, oPlayer, TRUE);
        }
    }
}

void main()
{
    object oPC = GetPCSpeaker();

    // spawn a horse for each party member who is not a flying sword or a horse
    int nHorse = 0;
    object oPlayer = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oPlayer) && GetArea(oPlayer) == GetArea(oPC))
    {
        if (GetRacialType(oPlayer) != RACIAL_TYPE_ANIMAL)
        {
            if (GetRacialType(oPlayer) != RACIAL_TYPE_CONSTRUCT)
            {
                CreateHorse(oPlayer, ++nHorse);
            }
        }
        oPlayer = GetNextFactionMember(oPC, FALSE);
    }

    // charge money for each horse that was spawned
    int nCost = COST_PER_HORSE * nHorse;
    TakeGoldFromCreature(nCost, oPC, TRUE);

    // if a horse was bought, update journal and award quest completion xp
    if(nHorse > 0 && GetLocalInt(oPC, "NW_JOURNAL_ENTRYTharMounts") < 20)
    {
        AddJournalQuestEntry("TharMounts", 20, oPC);
        int nXP = GetJournalQuestExperience("TharMounts");
        GiveXPToCreature(oPC, nXP);
    }

    // reset angrym's conversation
    PlotLevelSet("Angrym", 1);
}
