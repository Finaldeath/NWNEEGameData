//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oWorkItem = GetLocalObject(OBJECT_SELF, "oWorkItem");
    if (GetIsObjectValid(oWorkItem))
    {
        return;
    }
    else
    {
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
    }
}
