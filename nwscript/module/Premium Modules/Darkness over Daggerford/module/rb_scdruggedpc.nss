int StartingConditional()
{
     if(GetLocalInt(OBJECT_SELF, "iDruggedPC") == 1)
     {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
