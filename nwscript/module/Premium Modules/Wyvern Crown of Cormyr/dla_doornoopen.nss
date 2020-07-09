// B G P Hughes (B W-Huesy)
// August 2005
// For doors that are not meant to be opened.
void main()
{
//    BeginConversation("doornoopen",GetLastUsedBy());
    ActionStartConversation(GetClickingObject(),"doornoopen");
}
