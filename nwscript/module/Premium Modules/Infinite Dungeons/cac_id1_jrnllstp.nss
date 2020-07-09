void main()
{
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    nCurrentPage--;
    SetLocalInt(OBJECT_SELF, "nCurrentPage", nCurrentPage);
}
