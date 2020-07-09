//::///////////////////////////////////////////////
//:: Act 3: Gangplank, Rime Completed
//:: cac_a3_plankrime.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Flag a variable if the Rime was completed
     successfully.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 27, 2005
//:://////////////////////////////////////////////

void main()
{
    int bMistakes = GetLocalInt(GetModule(), "bGangplankMistake");

    //If there are no mistakes
    if (bMistakes == FALSE)
    {
        //Activate the Gangplank
        SetLocalInt(GetModule(), "bGangplankActivated", TRUE);
    }

    //Clear the Mistake variable.
    SetLocalInt(GetModule(), "bGangplankMistake", FALSE);
}
