void main()
{
    int nMin = GetLocalInt(OBJECT_SELF, "nMin");
    int nMax = GetLocalInt(OBJECT_SELF, "nMax");

    int nCurrentPage = 1;
    while (((nCurrentPage * 10) + nMin) <= nMax)
    {
        nCurrentPage++;
    }

    SetLocalInt(OBJECT_SELF, "nCurrentPage", nCurrentPage);
}
