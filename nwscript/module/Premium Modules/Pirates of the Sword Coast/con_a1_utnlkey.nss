//::///////////////////////////////////////////////
//:: con_a1_utnlkey
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If Utnal still has his key Give it to the
    player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oUtnal = OBJECT_SELF;
    int iKey = GetLocalInt(GetModule(), "cac_a1_utnlkey");
    int iReturn = FALSE;

    if (iKey == FALSE)
    {
        iReturn = TRUE;
    }

    return iReturn;
}


