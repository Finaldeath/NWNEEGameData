//::///////////////////////////////////////////////
//:: Generic Do Once
//:: con_do_once.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     A generic DoOnce condition script that ensures
     the node in question only fires once.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 22, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    int bDoOnce = GetLocalInt(OBJECT_SELF, "bDoOnce");

    if (bDoOnce == FALSE)
    {
        SetLocalInt(OBJECT_SELF, "bDoOnce", TRUE);
        return TRUE;
    }
    return FALSE;
}
