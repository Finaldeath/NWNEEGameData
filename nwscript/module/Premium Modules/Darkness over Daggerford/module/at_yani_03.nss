// increment yani's branch variable

void main()
{
    int n = GetLocalInt(OBJECT_SELF, "nBranch");
    SetLocalInt(OBJECT_SELF, "nBranch", ++n);
}
