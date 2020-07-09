//:://////////////////////////////////////////////
//:: nsp_a0_sitsailor
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Sailor will sit in the nearest object that
    has his CHR_ + his tag.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    string sChair = "CHR_" + GetTag(oSelf);
    object oChair = GetNearestObjectByTag(sChair);

    ExecuteScript("nw_c2_default1", OBJECT_SELF);

    // If the chair exists and nobody is sitting in it, sit.
    if ((GetIsObjectValid(oChair) == TRUE)
      && (GetIsObjectValid(GetSittingCreature(oChair)) == FALSE))
    {
        ActionSit(oChair);
    }
}
