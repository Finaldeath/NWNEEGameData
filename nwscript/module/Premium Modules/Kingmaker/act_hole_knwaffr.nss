//::///////////////////////////////////////////////
//:: PC Knows about Affair
//:: act_hold_knwaffr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has heard about Beckett's affair
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: Sept 2003
//:://////////////////////////////////////////////

void main()
{
    SetLocalInt(GetFirstPC(),"OS_BECKET_AFFAIR",10);
}
