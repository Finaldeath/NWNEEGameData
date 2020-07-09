//::///////////////////////////////////////////////
//:: con_a2_tttst30
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have released the Tattooist and he has
    offered you a favor in return.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlot = GetLocalInt(GetModule(), "A2_TTTST");

    if(iPlot >= 30)
    {
        return TRUE;
    }

    return FALSE;

}
