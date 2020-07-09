int StartingConditional()
{
    object oQuill = GetObjectByTag("DDF_NPC_Quillian");
    int iType = GetAssociateType(oQuill);

    if (iType == ASSOCIATE_TYPE_HENCHMAN)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
