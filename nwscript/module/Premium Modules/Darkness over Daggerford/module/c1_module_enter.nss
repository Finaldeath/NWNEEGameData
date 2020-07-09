#include "x3_inc_skin"

void SetupRacialTokens(object oPC)
{
    int nToken1 = 500;
    int nToken2 = 501;
    int nRace = GetRacialType(oPC);

    switch(nRace)
    {
        case RACIAL_TYPE_DWARF:
        {
            SetCustomToken(nToken1, "Dwarf");
            SetCustomToken(nToken2, "dwarf");
            break;
        }
        case RACIAL_TYPE_ELF:
        {
            SetCustomToken(nToken1, "Elf");
            SetCustomToken(nToken2, "elf");
            break;
        }
        case RACIAL_TYPE_GNOME:
        {
            SetCustomToken(nToken1, "Gnome");
            SetCustomToken(nToken2, "gnome");
            break;
        }
        case RACIAL_TYPE_HALFELF:
        {
            SetCustomToken(nToken1, "Half-Elf");
            SetCustomToken(nToken2, "half-elf");
            break;
        }
        case RACIAL_TYPE_HALFLING:
        {
            SetCustomToken(nToken1, "Halfling");
            SetCustomToken(nToken2, "halfling");
            break;
        }
        case RACIAL_TYPE_HALFORC:
        {
            SetCustomToken(nToken1, "Half-Orc");
            SetCustomToken(nToken2, "half-orc");
            break;
        }
        case RACIAL_TYPE_HUMAN:
        {
            SetCustomToken(nToken1, "Human");
            SetCustomToken(nToken2, "human");
            break;
        }
        default:
        {
            SetCustomToken(nToken1, "Unrecognized-Race");
            SetCustomToken(nToken2, "unrecognized-race");
            break;
        }
    }
}

void main()
{
    object oPC = GetEnteringObject();

    SetupRacialTokens(oPC);

    //Ensure PC Properties is created
    object oSkin=SKIN_SupportGetSkin(oPC);
}
