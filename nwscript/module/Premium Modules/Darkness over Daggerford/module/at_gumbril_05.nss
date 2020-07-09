void main()
{
    string sClericTag = GetLocalString(GetModule(), "UmgatlikCleric");
    if (sClericTag == "ks_jared")
    {
        SetCustomToken(100, "Jared");
    }
    else
    {
        SetCustomToken(100, "Vetrixia");
    }
}
