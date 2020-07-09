//::///////////////////////////////////////////////
//:: con_pcis_lfemale
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC Speaker large pheno type female?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPheno = GetPhenoType(oPC);
    int iGender = GetGender(oPC);
    int iResult = FALSE;

    if ((iGender == GENDER_FEMALE) && (iPheno == PHENOTYPE_BIG))
    {
        iResult = TRUE;
    }

    return iResult;
}
