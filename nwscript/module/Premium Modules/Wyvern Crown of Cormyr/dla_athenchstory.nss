void main()
{
    int nStory = GetLocalInt(OBJECT_SELF,"nMyStory");
    SetLocalInt(OBJECT_SELF,"nMyStory",nStory+1);
}
