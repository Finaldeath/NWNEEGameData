int StartingConditional()
{
    int bFail = GetLocalInt(OBJECT_SELF, "bImportFailed");
    if (bFail == TRUE)
    {
        object oImport = GetLocalObject(OBJECT_SELF, "oImport");
        DestroyObject(oImport);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
