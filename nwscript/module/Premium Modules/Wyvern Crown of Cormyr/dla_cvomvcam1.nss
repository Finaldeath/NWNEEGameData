//pan the camera in conversation to get a better look at wyvernvapor
void main()
{
    AssignCommand(GetPCSpeaker(), SetCameraFacing(45.0,-1.0,-1.0,CAMERA_TRANSITION_TYPE_SLOW));
}
