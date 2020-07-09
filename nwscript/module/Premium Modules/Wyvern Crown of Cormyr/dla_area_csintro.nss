////////////////////////////////////////////////////////////////////////////////
// dla_area_csintro
// DLA
////////////////////////////////////////////////////////////////////////////////
/*
    Area OnEnter event script for the starting area of Wyvern Crown
 */
////////////////////////////////////////////////////////////////////////////////
// Created by: Syrsnein
// April 2006
////////////////////////////////////////////////////////////////////////////////
/* Change list
    June 7, 2006: Syrsnein
        Added DLA_GetIsCharacterNameValid() using Deva Winblood's code from
            another script.  Modified it to fit with this context.
        Added conditional check for a valid name. If the character name is not
            valid, the player will get shipped to an isolated room to have it
            explained to him.
    June 11, 2006: Syrsnein
        Added a level check in order to advise the player if his character is
        too high a level for a challenging game experience.
    June 12, 2006: Syrsnein
        Added a deity check.
    July 4th - B G P Hughes - it's all broken, so I've switched it all off and reverted to just the Deity set.
        Please fix so the deity is set, the name warning floaty is given at cutscene end.
    July 7th - added plot variable check here. Looks like with all the changes it may be deleted.
    July 19th - added version journal support and corrected deity
 */
#include "dla_i0_strings"
#include "cu_functions"

int DLA_GetIsDeityValid(string sDeity)
{ // PURPOSE: to return TRUE if s Deity is a valid deity name

     if (sDeity=="Cyric"||sDeity=="Bane") return TRUE;
     else if (sDeity=="Chauntea") return TRUE;
     else if (sDeity=="Deneir") return TRUE;
     else if (sDeity=="Helm") return TRUE;
     else if (sDeity=="Lathander") return TRUE;
     else if (sDeity=="Lliira") return TRUE;
     else if (sDeity=="Oghma") return TRUE;
     else if (sDeity=="Tyr") return TRUE;
     else if (sDeity=="Torm") return TRUE;
     else if (sDeity=="Malar") return TRUE;
     else if (sDeity=="Selune") return TRUE;
     else if (sDeity=="Milil") return TRUE;
     else if (sDeity=="Silvanus"||sDeity=="Tempus"||sDeity=="Tymora") return TRUE;
     else if (sDeity=="Waukeen"||sDeity=="Moradin") return TRUE;
     else if (sDeity=="Dumathoin"||sDeity=="Vergadain") return TRUE;
     else if (sDeity=="Corellon Larethian") return TRUE;
     else if (sDeity=="Garl Glittergold"||sDeity=="Callarduran Smoothhands") return TRUE;
     else if (sDeity=="Yondalla"||sDeity=="Sheela Peryroyl"||sDeity=="Brandobaris") return TRUE;
     else if (sDeity=="Gruumsh"||sDeity=="Lloth") return TRUE;

     return FALSE;
} // DLA_GetIsDeityValid()


/*
int DLA_GetIsDeityValid(object oPC)
{
    string sDeity = GetDeity(oPC);
    if (sDeity == "")
    { // PC has no diety
        return FALSE;
    }
    int nAlignGE = GetAlignmentGoodEvil(oPC);
    int nAlignLC = GetAlignmentLawChaos(oPC);

    string sLG = ".tyr.lathandar.selune.helm.silvanus.tempus.";
    string sLN = ".tyr.lathandar.helm.bane.cyric.silvanus.tempus.";
    string sLE = ".bane.cyric.malar.silvanus.tempus.";
    string sNG = ".try.lathandar.selune.helm.silvanus.tempus.";
    string sNN = ".lathandar.helm.bane.cyric.malar.silvanus.tempus.";
    string sNE = ".bane.cyric.malar.silvanus.tempus.";
    string sCG = ".lathandar.selune.helm.silvanus.tempus.";
    string sCN = ".lathandar.helm.bane.cyric.malar.silvanus.tempus.";
    string sCE = ".bane.cyric.malar.silvanus.tempus.";

    string sCompare;
    if (nAlignLC == ALIGNMENT_LAWFUL)
    {
        if (nAlignGE == ALIGNMENT_GOOD)
        {
            sCompare = sLG;
        }
        if (nAlignGE == ALIGNMENT_NEUTRAL)
        {
            sCompare = sLN;
        }
        if (nAlignGE == ALIGNMENT_EVIL)
        {
            sCompare = sLE;
        }
    }
    if (nAlignLC == ALIGNMENT_NEUTRAL)
    {
        if (nAlignGE == ALIGNMENT_GOOD)
        {
            sCompare = sNG;
        }
        if (nAlignGE == ALIGNMENT_NEUTRAL)
        {
            sCompare = sNN;
        }
        if (nAlignGE == ALIGNMENT_EVIL)
        {
            sCompare = sNE;
        }
    }
    if (nAlignLC == ALIGNMENT_CHAOTIC)
    {
        if (nAlignGE == ALIGNMENT_GOOD)
        {
            sCompare = sCG;
        }
        if (nAlignGE == ALIGNMENT_NEUTRAL)
        {
            sCompare = sCN;
        }
        if (nAlignGE == ALIGNMENT_EVIL)
        {
            sCompare = sCE;
        }
    }
    sDeity = "." + GetStringLowerCase(sDeity) + ".";
    return (FindSubString(sCompare, sDeity) >= 0);
}

int DLA_GetIsCharacterNameValid(string sName)
{
   int nWordCount=0;
   string sLower=GetStringLowerCase(sName);
   if (GetStringLength(sLower)>0)
   { // count words
     sLower=DLA_ParseRight(sName," ");
     if (sLower=="the"||sLower=="a"||sLower=="an")
     { // invalid
       return FALSE;
     } // invalid
     nWordCount++;
     sName=DLA_RemoveParsedLeft(sName,sLower," ");
     while(GetStringLength(sName)>0)
     { // count words
       sLower=DLA_ParseRight(sName," ");
       if (sLower=="the"||sLower=="a"||sLower=="an")
       { // invalid
         return FALSE;
       } // invalid
       nWordCount++;
       sName=DLA_RemoveParsedLeft(sName,sLower," ");
     } // count words
     if (nWordCount!=2)
     { // Invalid word count
        return FALSE;
     }
   } // count words
   return TRUE;
}
*/
void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC))
    { // Not a PC, return
        return;
    } // Not a PC
    if (GetLocalInt(oPC,"nModStarted"))
    { // Module has already been started by this character, return
        return;
    } // Module has already been started

    // Blackout to start the cutscene(s)
    BlackScreen(oPC);




    // get booleans for name and level checks
    int bNameChecked    = GetLocalInt(oPC, "bNameChecked");
    int bLevelChecked   = GetLocalInt(oPC, "bLevelChecked");
    int bDeityChecked   = GetLocalInt(oPC, "bDeityChecked");

    /*

    // Do a name check on new character in the module
    if (!bNameChecked)
    { // Name has not been checked before
        if (DLA_GetIsCharacterNameValid(GetName(oPC)))
        { // Name is good
            bNameChecked = TRUE;
        } // Name is good
        SetLocalInt(oPC, "bNameChecked", bNameChecked);
    }
    */
    // Do Level check on new character in the module
    if (!bLevelChecked)
    { // Level has not been checked before
        int nXP = GetXP(oPC);
        if (nXP < 28000)
        { // Experience Level is under recommended max
            if (nXP < 15000)
            { // Boost experience level
                SetXP(oPC,15000);
            } // Boost experience
            bLevelChecked = TRUE;
        } // Experience level
        SetLocalInt(oPC, "bLevelChecked", bLevelChecked);
    }

    // Do a Deity check since there are deity related bits in the game.
    /*
    if (!bDeityChecked)
    {
        if (DLA_GetIsDeityValid(oPC))
        {
            bDeityChecked = TRUE;
        }
        SetLocalInt(oPC, "bDeityChecked", bDeityChecked);
    }

    */

     //===set deity == choices limited to those with specific items
     if (GetDeity(oPC) =="") // PC forgot to pick a deity
     {
        string sGod;
        if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL)
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Silvanus";
            else if (GetAlignmentLawChaos(oPC)==ALIGNMENT_CHAOTIC) sGod = "Cyric";
            else sGod = "Malar";
        }
        else if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD)
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Tyr";
            else if (GetAlignmentLawChaos(oPC)==ALIGNMENT_CHAOTIC) sGod = "Selune";
            else sGod = "Lathander";
        }
        else
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Helm";
            else if (GetAlignmentLawChaos(oPC)==ALIGNMENT_CHAOTIC) sGod = "Silvanus";
            else sGod = "Silvanus";
        }
        SetDeity(oPC,sGod);
        FloatingTextStringOnCreature("Deity set to "+sGod,oPC,FALSE);
     }

//    if (bNameChecked && bLevelChecked && bDeityChecked)
//    { // Name and level have been checked
        if (!GetLocalInt(GetModule(),"bNoVersionJournal"))
        { // add version information to journal
             AddJournalQuestEntry("version",1,oPC,TRUE,TRUE,TRUE);
        } // add version information to journal
        if (!DLA_GetIsDeityValid(GetDeity(oPC)))
        { // correct
             ExecuteScript("dla_miscdeity",oPC);
        } // correct
        SetCustomToken(1056,GetDeity(oPC));
        // Strip all equipment from the PC
        ExecuteScript("dla_miscstrip",oPC);
        // ReEquip the PC
        ExecuteScript("dla_miscequip",oPC);
        AllParty("nMainPlot",oPC,1);
        // Start the cutscene
        AssignCommand(oPC, JumpToObject(GetWaypointByTag("WP_FarmCamera1")));
//    } // Name and level checks done
/*
    if (!bNameChecked || !bLevelChecked || !bDeityChecked)
    { // Bad Name or starting level
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("WP_InvalidName"))));
        SendMessageToPC(oPC,DLA_SetStringColor("WARNING! Your name is likely to cause problems for you in this module.  A character with a First and Last Name only is best.","622"));
    } // Bad Name or starting level
*/
}
