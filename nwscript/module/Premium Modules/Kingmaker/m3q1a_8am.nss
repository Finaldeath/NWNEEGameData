//::///////////////////////////////////////////////
//:: M3Q1A_8AM
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Checks to see if it's 8 a.m.
*/
//:://////////////////////////////////////////////
//:: Created By:    Cori May
//:: Created On:    April 7, 2002
//:://////////////////////////////////////////////

int StartingConditional()
{
    if(GetTimeHour()==8)
    {
        return TRUE;
    }
    return FALSE;
}