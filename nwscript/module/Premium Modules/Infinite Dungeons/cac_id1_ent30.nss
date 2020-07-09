void main()
{
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    nCurrentPage += 10;
    SetLocalInt(OBJECT_SELF, "nCurrentPage", nCurrentPage);
}
