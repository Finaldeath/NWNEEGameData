//:://////////////////////////////////////////////
//:: ncv_a0_sailorsit
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Sailor will sit in the nearest object that
    has his CHR_ + his tag. This is to keep the
    NPC seated, even when spoken too.
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

    ExecuteScript("nw_c2_default4", oSelf);

    if ((GetIsObjectValid(oChair) == TRUE)
      && (GetIsObjectValid(GetSittingCreature(oChair)) == FALSE))
    {
        ActionSit(oChair);
    }
}
