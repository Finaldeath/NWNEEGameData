//::///////////////////////////////////////////////
//:: dla_i0_opponents
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Sysrnein 27 Feb 2006: created this file and moved constants and comments
    into it.

    Include file used for Joust opponent setup

    Gale 17 Jan 2006: Constants to keep track of opponents names/resrefs
    (tags on blueprint are overrided, and resref is used instead)

    If it's needed to set a specific behavior, edit script dla_jt_joustcont
    more detailed instructions are present there.

    Sysrnein 27 Feb 2006: Added other constants dealing with setting up opponents
    B W-Husey 30th March - fixed small race names and the Black Knight name call

*/
//:://////////////////////////////////////////////
//:: Create By: Syrsnein
//:: Created On: Feb 27, 2006
//:://////////////////////////////////////////////

const int DLA_JOUST_MAX_OPPONENTS   = 8;
const int DLA_JOUST_OPPONENT_JONAS  = 9;

///////////////////////////////////////
//Medium sized // Jousting opponents //
///////////////////////////////////////

const string DLA_JOUST_OPPONENT1_NAME = "Sir Azar Truesilver";
const string DLA_JOUST_OPPONENT2_NAME = "Sir Drake Huntcrown";
const string DLA_JOUST_OPPONENT3_NAME = "Sir Reginald Huntsilver";
const string DLA_JOUST_OPPONENT4_NAME = "Sir Baradin Hawklin";
const string DLA_JOUST_OPPONENT5_NAME = "Lady Morgana Wyvernspur";
const string DLA_JOUST_OPPONENT6_NAME = "Sir Blakeney Hawklin";
const string DLA_JOUST_OPPONENT7_NAME = "Lady Arianne FitzCormaeril";
const string DLA_JOUST_OPPONENT8_NAME = "Sir Giolin Wyvernspur";
const string DLA_JOUST_OPPONENT9_NAME = "the Black Knight";
const string DLA_JOUST_OPPONENT10_NAME = "";

const string DLA_JOUST_OPPONENT1_RESREF = "dla_opp_joust001";
const string DLA_JOUST_OPPONENT2_RESREF = "dla_opp_joust002";
const string DLA_JOUST_OPPONENT3_RESREF = "dla_opp_joust003";
const string DLA_JOUST_OPPONENT4_RESREF = "dla_opp_joust004";
const string DLA_JOUST_OPPONENT5_RESREF = "dla_opp_joust005";
const string DLA_JOUST_OPPONENT6_RESREF = "dla_opp_joust006";
const string DLA_JOUST_OPPONENT7_RESREF = "dla_opp_joust007";
const string DLA_JOUST_OPPONENT8_RESREF = "dla_opp_joust008";
const string DLA_JOUST_OPPONENT9_RESREF = "jonas";
const string DLA_JOUST_OPPONENT10_RESREF = "";

//////////////////////////////////////
// Small races // Jousting opponents//
//////////////////////////////////////

const string DLA_JOUST_SM_OPPONENT1_NAME = "Bandobras Tolman";
const string DLA_JOUST_SM_OPPONENT2_NAME = "Baldo Tolman";
const string DLA_JOUST_SM_OPPONENT3_NAME = "Stren Sternhelm";
const string DLA_JOUST_SM_OPPONENT4_NAME = "Hathnor Thunderbrow";
const string DLA_JOUST_SM_OPPONENT5_NAME = "Rose Greenwood";
const string DLA_JOUST_SM_OPPONENT6_NAME = "Inuman Insar";
const string DLA_JOUST_SM_OPPONENT7_NAME = "Lady Arianne FitzCormaeril";
const string DLA_JOUST_SM_OPPONENT8_NAME = "Millas Hoffin";
const string DLA_JOUST_SM_OPPONENT9_NAME = "the Black Knight";
const string DLA_JOUST_SM_OPPONENT10_NAME = "";

const string DLA_JOUST_SM_OPPONENT1_RESREF = "dla_opps_joust01";
const string DLA_JOUST_SM_OPPONENT2_RESREF = "dla_opps_joust02";
const string DLA_JOUST_SM_OPPONENT3_RESREF = "dla_opps_joust03";
const string DLA_JOUST_SM_OPPONENT4_RESREF = "dla_opps_joust04";
const string DLA_JOUST_SM_OPPONENT5_RESREF = "dla_opps_joust05";
const string DLA_JOUST_SM_OPPONENT6_RESREF = "dla_opps_joust06";
const string DLA_JOUST_SM_OPPONENT7_RESREF = "dla_opps_joust07";
const string DLA_JOUST_SM_OPPONENT8_RESREF = "dla_opps_joust08";
const string DLA_JOUST_SM_OPPONENT9_RESREF = "jonas";
const string DLA_JOUST_SM_OPPONENT10_RESREF = "";

//////////////////////////////////////
//Medium Sized // Training opponents//
//////////////////////////////////////

const string DLA_JOUST_TR_OPPONENT1_NAME = "Squire Victor Wyvernspur";
const string DLA_JOUST_TR_OPPONENT2_NAME = "Squire Daedin Hawklin";
const string DLA_JOUST_TR_OPPONENT3_NAME = "Squire Fiona Huntcrown";
const string DLA_JOUST_TR_OPPONENT4_NAME = "Squire Raelyn Huntsilver";
const string DLA_JOUST_TR_OPPONENT5_NAME = "Squire Argon Truesilver";
const string DLA_JOUST_TR_OPPONENT6_NAME = "Squire Gherad Wyvernspur";
const string DLA_JOUST_TR_OPPONENT7_NAME = "Squire Cynne Hawklin";
const string DLA_JOUST_TR_OPPONENT8_NAME = "Squire Tamlin FitzCormaeril";
const string DLA_JOUST_TR_OPPONENT9_NAME = "";
const string DLA_JOUST_TR_OPPONENT10_NAME = "";

const string DLA_JOUST_TR_OPPONENT1_RESREF = "dla_trn_joust001";
const string DLA_JOUST_TR_OPPONENT2_RESREF = "dla_trn_joust002";
const string DLA_JOUST_TR_OPPONENT3_RESREF = "dla_trn_joust003";
const string DLA_JOUST_TR_OPPONENT4_RESREF = "dla_trn_joust004";
const string DLA_JOUST_TR_OPPONENT5_RESREF = "dla_trn_joust005";
const string DLA_JOUST_TR_OPPONENT6_RESREF = "dla_trn_joust006";
const string DLA_JOUST_TR_OPPONENT7_RESREF = "dla_trn_joust007";
const string DLA_JOUST_TR_OPPONENT8_RESREF = "dla_trn_joust008";
const string DLA_JOUST_TR_OPPONENT9_RESREF = "";
const string DLA_JOUST_TR_OPPONENT10_RESREF = "";

///////////////////////////////////////
// Small races // Training opponents //
///////////////////////////////////////

const string DLA_JOUST_TR_SM_OPPONENT1_NAME = "Gamolin Ironstone";
const string DLA_JOUST_TR_SM_OPPONENT2_NAME = "Hamish Burfoot";
const string DLA_JOUST_TR_SM_OPPONENT3_NAME = "Roslyn Halftall";
const string DLA_JOUST_TR_SM_OPPONENT4_NAME = "Felnas Warren";
const string DLA_JOUST_TR_SM_OPPONENT5_NAME = "Maryn Holden";
const string DLA_JOUST_TR_SM_OPPONENT6_NAME = "Aryl Flynn";
const string DLA_JOUST_TR_SM_OPPONENT7_NAME = "Damargol Hammerfist";
const string DLA_JOUST_TR_SM_OPPONENT8_NAME = "Sudri Thunderbrow";
const string DLA_JOUST_TR_SM_OPPONENT9_NAME = "";
const string DLA_JOUST_TR_SM_OPPONENT10_NAME = "";

const string DLA_JOUST_TR_SM_OPPONENT1_RESREF = "dla_trns_joust01";
const string DLA_JOUST_TR_SM_OPPONENT2_RESREF = "dla_trns_joust02";
const string DLA_JOUST_TR_SM_OPPONENT3_RESREF = "dla_trns_joust03";
const string DLA_JOUST_TR_SM_OPPONENT4_RESREF = "dla_trns_joust04";
const string DLA_JOUST_TR_SM_OPPONENT5_RESREF = "dla_trns_joust05";
const string DLA_JOUST_TR_SM_OPPONENT6_RESREF = "dla_trns_joust06";
const string DLA_JOUST_TR_SM_OPPONENT7_RESREF = "dla_trns_joust07";
const string DLA_JOUST_TR_SM_OPPONENT8_RESREF = "dla_trns_joust08";
const string DLA_JOUST_TR_SM_OPPONENT9_RESREF = "";
const string DLA_JOUST_TR_SM_OPPONENT10_RESREF = "";

///////////////////////////////////////////
// Jousting opponent type set            //
///////////////////////////////////////////
const int DLA_OPPONENT_SET_NONE     = 0;
const int DLA_OPPONENT_SET_TRAINING = 1;
const int DLA_OPPONENT_SET_TOURNEY  = 2;


////////////////////////////////////////////////////////////////////////////////
//Private functions
string DLA_FindTrainingOppName(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_TR_OPPONENT1_NAME;
        case  2: return DLA_JOUST_TR_OPPONENT2_NAME;
        case  3: return DLA_JOUST_TR_OPPONENT3_NAME;
        case  4: return DLA_JOUST_TR_OPPONENT4_NAME;
        case  5: return DLA_JOUST_TR_OPPONENT5_NAME;
        case  6: return DLA_JOUST_TR_OPPONENT6_NAME;
        case  7: return DLA_JOUST_TR_OPPONENT7_NAME;
        case  8: return DLA_JOUST_TR_OPPONENT8_NAME;
        case  9: return DLA_JOUST_TR_OPPONENT9_NAME;
        case 10: return DLA_JOUST_TR_OPPONENT10_NAME;
    }
    return "";
}

string DLA_FindTourneyOppName(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_OPPONENT1_NAME;
        case  2: return DLA_JOUST_OPPONENT2_NAME;
        case  3: return DLA_JOUST_OPPONENT3_NAME;
        case  4: return DLA_JOUST_OPPONENT4_NAME;
        case  5: return DLA_JOUST_OPPONENT5_NAME;
        case  6: return DLA_JOUST_OPPONENT6_NAME;
        case  7: return DLA_JOUST_OPPONENT7_NAME;
        case  8: return DLA_JOUST_OPPONENT8_NAME;
        case  9: return DLA_JOUST_OPPONENT9_NAME;
        case 10: return DLA_JOUST_OPPONENT10_NAME;
    }
    return "";
}

string DLA_FindSmallTrainingOppName(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_TR_SM_OPPONENT1_NAME;
        case  2: return DLA_JOUST_TR_SM_OPPONENT2_NAME;
        case  3: return DLA_JOUST_TR_SM_OPPONENT3_NAME;
        case  4: return DLA_JOUST_TR_SM_OPPONENT4_NAME;
        case  5: return DLA_JOUST_TR_SM_OPPONENT5_NAME;
        case  6: return DLA_JOUST_TR_SM_OPPONENT6_NAME;
        case  7: return DLA_JOUST_TR_SM_OPPONENT7_NAME;
        case  8: return DLA_JOUST_TR_SM_OPPONENT8_NAME;
        case  9: return DLA_JOUST_TR_SM_OPPONENT9_NAME;
        case 10: return DLA_JOUST_TR_SM_OPPONENT10_NAME;
    }
    return "";
}

string DLA_FindSmallTourneyOppName(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_SM_OPPONENT1_NAME;
        case  2: return DLA_JOUST_SM_OPPONENT2_NAME;
        case  3: return DLA_JOUST_SM_OPPONENT3_NAME;
        case  4: return DLA_JOUST_SM_OPPONENT4_NAME;
        case  5: return DLA_JOUST_SM_OPPONENT5_NAME;
        case  6: return DLA_JOUST_SM_OPPONENT6_NAME;
        case  7: return DLA_JOUST_SM_OPPONENT7_NAME;
        case  8: return DLA_JOUST_SM_OPPONENT8_NAME;
        case  9: return DLA_JOUST_SM_OPPONENT9_NAME;
        case 10: return DLA_JOUST_SM_OPPONENT10_NAME;
    }
    return "";
}

string DLA_FindTrainingOppResref(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_TR_OPPONENT1_RESREF;
        case  2: return DLA_JOUST_TR_OPPONENT2_RESREF;
        case  3: return DLA_JOUST_TR_OPPONENT3_RESREF;
        case  4: return DLA_JOUST_TR_OPPONENT4_RESREF;
        case  5: return DLA_JOUST_TR_OPPONENT5_RESREF;
        case  6: return DLA_JOUST_TR_OPPONENT6_RESREF;
        case  7: return DLA_JOUST_TR_OPPONENT7_RESREF;
        case  8: return DLA_JOUST_TR_OPPONENT8_RESREF;
        case  9: return DLA_JOUST_TR_OPPONENT9_RESREF;
        case 10: return DLA_JOUST_TR_OPPONENT10_RESREF;
    }
    return "";
}

string DLA_FindTourneyOppResref(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_OPPONENT1_RESREF;
        case  2: return DLA_JOUST_OPPONENT2_RESREF;
        case  3: return DLA_JOUST_OPPONENT3_RESREF;
        case  4: return DLA_JOUST_OPPONENT4_RESREF;
        case  5: return DLA_JOUST_OPPONENT5_RESREF;
        case  6: return DLA_JOUST_OPPONENT6_RESREF;
        case  7: return DLA_JOUST_OPPONENT7_RESREF;
        case  8: return DLA_JOUST_OPPONENT8_RESREF;
        case  9: return DLA_JOUST_OPPONENT9_RESREF;
        case 10: return DLA_JOUST_OPPONENT10_RESREF;
    }
    return "";
}

string DLA_FindSmallTrainingOppResref(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_TR_SM_OPPONENT1_RESREF;
        case  2: return DLA_JOUST_TR_SM_OPPONENT2_RESREF;
        case  3: return DLA_JOUST_TR_SM_OPPONENT3_RESREF;
        case  4: return DLA_JOUST_TR_SM_OPPONENT4_RESREF;
        case  5: return DLA_JOUST_TR_SM_OPPONENT5_RESREF;
        case  6: return DLA_JOUST_TR_SM_OPPONENT6_RESREF;
        case  7: return DLA_JOUST_TR_SM_OPPONENT7_RESREF;
        case  8: return DLA_JOUST_TR_SM_OPPONENT8_RESREF;
        case  9: return DLA_JOUST_TR_SM_OPPONENT9_RESREF;
        case 10: return DLA_JOUST_TR_SM_OPPONENT10_RESREF;
    }
    return "";
}

string DLA_FindSmallTourneyOppResref(int nIndex)
{
    switch (nIndex)
    {
        case  1: return DLA_JOUST_SM_OPPONENT1_RESREF;
        case  2: return DLA_JOUST_SM_OPPONENT2_RESREF;
        case  3: return DLA_JOUST_SM_OPPONENT3_RESREF;
        case  4: return DLA_JOUST_SM_OPPONENT4_RESREF;
        case  5: return DLA_JOUST_SM_OPPONENT5_RESREF;
        case  6: return DLA_JOUST_SM_OPPONENT6_RESREF;
        case  7: return DLA_JOUST_SM_OPPONENT7_RESREF;
        case  8: return DLA_JOUST_SM_OPPONENT8_RESREF;
        case  9: return DLA_JOUST_SM_OPPONENT9_RESREF;
        case 10: return DLA_JOUST_SM_OPPONENT10_RESREF;
    }
    return "";
}

// Testing function
string DLA_FindName(int nSize, int nIndex, int bTraining)
{
    int bSmall = (nSize>1);

    if (!bSmall)
    {
        if (bTraining) return DLA_FindTrainingOppName(nIndex);
        else           return DLA_FindTourneyOppName (nIndex);
    }
    else
    {
        if (bTraining) return DLA_FindSmallTrainingOppName(nIndex);
        else           return DLA_FindSmallTourneyOppName (nIndex);
    }
}

// Testing function
string DLA_FindResref(int nSize, int nIndex, int bTraining)
{
    int bSmall = (nSize>1);

    if (!bSmall)
    {
        if (bTraining) return DLA_FindTrainingOppResref(nIndex);
        else           return DLA_FindTourneyOppResref (nIndex);
    }
    else
    {
        if (bTraining) return DLA_FindSmallTrainingOppResref(nIndex);
        else           return DLA_FindSmallTourneyOppResref (nIndex);
    }
}

// Private functions
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// Public functions
// Prototypint

//Syrsnein 28 Feb 2006: Find the opponent name
string DLA_FindOpponentName(object oPC, int nIndex, int bTraining);

//Syrsnein 28 Feb 2006: Find the opponent resref
string DLA_FindOpponentResref(object oPC, int nIndex, int bTraining);

string DLA_FindOpponentName(object oPC, int nIndex, int bTraining)
{
    int bSmall = (GetCreatureSize(oPC)<CREATURE_SIZE_MEDIUM ||
                  GetRacialType(oPC)==RACIAL_TYPE_DWARF);

    if (!bSmall)
    {
        if (bTraining) return DLA_FindTrainingOppName(nIndex);
        else           return DLA_FindTourneyOppName (nIndex);
    }
    else
    {
        if (bTraining) return DLA_FindSmallTrainingOppName(nIndex);
        else           return DLA_FindSmallTourneyOppName (nIndex);
    }
}

string DLA_FindOpponentResref(object oPC, int nIndex, int bTraining)
{
    if (!bTraining && nIndex>8)
    {
        int nRace = GetRacialType(oPC);
        string sResRef = "jonas";
        string sRace = "human";
        switch (nRace)
        {
            case RACIAL_TYPE_DWARF:     sRace = "dwarf"     ; break;
            case RACIAL_TYPE_ELF:       sRace = "elf"       ; break;
            case RACIAL_TYPE_GNOME:     sRace = "gnome"     ; break;
            case RACIAL_TYPE_HALFELF:   sRace = "halfelf"   ; break;
            case RACIAL_TYPE_HALFLING:  sRace = "halfling"  ; break;
            case RACIAL_TYPE_HALFORC:   sRace = "halforc"   ; break;
            default: // Human
                                        sRace = "human"     ; break;
        }
        sResRef += sRace;
        return ("jonas"+sRace);
    }

    int bSmall = (GetCreatureSize(oPC)<CREATURE_SIZE_MEDIUM ||
                  GetRacialType(oPC)==RACIAL_TYPE_DWARF);

    if (!bSmall)
    {
        if (bTraining) return DLA_FindTrainingOppResref(nIndex);
        else           return DLA_FindTourneyOppResref (nIndex);
    }
    else
    {
        if (bTraining) return DLA_FindSmallTrainingOppResref(nIndex);
        else           return DLA_FindSmallTourneyOppResref (nIndex);
    }
}
// void main() {}
