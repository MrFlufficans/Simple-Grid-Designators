// If we don't have a Laser we exit early
if !FF_SimpleGrid_TestIsLaser exitWith {};

// If Both are Defined we need to Reset and start from the Beginning
if (!(FF_SimpleGrid_point1 isEqualTo [0,0,0]) && !(FF_SimpleGrid_point2 isEqualTo [0,0,0])) then {
	FF_SimpleGrid_point1 = [0,0,0];
	FF_SimpleGrid_point2 = [0,0,0];
	FF_SimpleGrid_Relative_B = 0;
	FF_SimpleGrid_Relative_R = 0;
};

// Create the UI
"FF_SimpleGrid_HUD_Relative" cutRsc ["FF_SimpleGrid_HUD_Relative", "PLAIN", -1, false];

// If the First Point is Equal to the Default then we Set that, If not we set the Second
if (FF_SimpleGrid_point1 isEqualTo [0,0,0]) then {
	// Copy the Current Laser Position
	FF_SimpleGrid_point1 = +FF_SimpleGrid_laserPos;

	// Play a Sound to signify to the player that they have successfully set the first point
	playsoundUI ["Topic_Trigger", 0.2];
} else {
	// Copy the Current Laser Position
	FF_SimpleGrid_point2 = +FF_SimpleGrid_laserPos;
	
	// We also Do all the Things now since the Second Position has been Identified
	FF_SimpleGrid_Relative_B = round(FF_SimpleGrid_point1 getDir FF_SimpleGrid_point2);
	FF_SimpleGrid_Relative_R = round(FF_SimpleGrid_point1 distance FF_SimpleGrid_point2);
	
	// Play a Sound to signify a Full Action has been completed
	playSoundUI ["FF_SimpleGrid_Designator1", 0.2];
};
