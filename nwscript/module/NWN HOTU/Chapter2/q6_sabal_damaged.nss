//::///////////////////////////////////////////////
//:: Name x2_def_ondamage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDamaged script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if(GetPlotFlag(OBJECT_SELF) == TRUE)
        return;
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}