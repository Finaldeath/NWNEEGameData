// Sends a soldier back to their post.

void main()
{
    ActionMoveToObject(GetObjectByTag(GetLocalString(OBJECT_SELF,"Post")),TRUE,0.0);
}
