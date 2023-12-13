FF_SimpleGrid_Designators_Main = [] spawn {

// Wait til the Player's UI has loaded
waitUntil {
	sleep 1;
	!isNull (findDisplay 46);
};

// Need to exit early if we aren't a client
if !hasInterface exitWith {};

// Sets up Some Variables for Each Session
if (isNil "FF_SimpleGrid_CreationType") then {FF_SimpleGrid_CreationType == "Modded"};
FF_SimpleGrid_MarkerType = "FF_SimpleGrid_Marker1";
FF_SimpleGrid_MarkerName = "Waypoint";
FF_SimpleGrid_MarkerColour = "ColorBlack";
FF_SimpleGrid_MarkerColourName = "Black";
FF_SimpleGrid_PlaceMarker = 0;
FF_SimpleGrid_InUI = false;
FF_SimpleGrid_laserPos = [0,0,0];
FF_SimpleGrid_point1 = [0,0,0];
FF_SimpleGrid_point2 = [0,0,0];
FF_SimpleGrid_Relative_B = 0;
FF_SimpleGrid_Relative_R = 0;

FF_SimpleGrid_ConditionLoop = [] spawn {

	while {true} do {

		// We do a sleep that is based on whether we have a Laser to use
		sleep 0.1;

		// If the Player is in the Gunner View, Looking down Sights or using a Turret drone or otherwise
		_inSights = cameraView == "GUNNER";

		// If the player has a Drone connected
		_hasDrone = !isNull getConnectedUAV player;
		// If the player is Actively connected to the Drone and Controlling it's Gunner Seat
		// Will need to find a better way Later this really isn't great if the Drone is using a different Scheme
		_inDrone = ((UAVControl getConnectedUAV player) select 1) isEqualTo "GUNNER";

		// If the player is in a Vehicle
		_inVehicle = !isNull (objectParent player);

		// If the player has Batteries and is
		_laserBatteryProxies = (FF_SimpleGrid_laserBatteryProxies splitString ", ");
		_hasBatteries = (currentMagazine player) in _laserBatteryProxies;

		FF_SimpleGrid_InUI = false;

		// Switch Case to handle which Eventuality to use
		FF_SimpleGrid_TestIsLaser = switch (true) do {
			
			// Early Case if the Mod is Disabled
			case (FF_SimpleGrid_DisableDesignators): {
				// Do absolutely Nothing
				FF_SimpleGrid_InUI = false;
				false;
			};
			
			// For when player is using a Drone
			case (_inSights && _hasDrone && _inDrone): {
				
				// Laser Position
				FF_SimpleGrid_laserPos = getPosASL laserTarget getConnectedUAV player;

				// List of Magazines for the Current Turret the player occupies and if it has a Laser
				_turretHasLaser = ((getConnectedUAV player) magazinesTurret ((getConnectedUAV player) unitTurret (getConnectedUAVUnit player))) findIf {_x in _laserBatteryProxies};

				if (_turretHasLaser > -1) then {
					FF_SimpleGrid_InUI = true;
				} else {
					FF_SimpleGrid_InUI = false;
				};

				// If the Laser is on
				if !(FF_SimpleGrid_laserPos isEqualTo [0,0,0]) then {
					FF_SimpleGrid_ObserverPos = (getPosASL getConnectedUAV player);
					FF_SimpleGrid_TargetHeight = (FF_SimpleGrid_laserPos select 2);
					true;
				} else {false};
				
			};

			// When the Player is inside a vehicle, including Turrets and FFV
			case (_inSights && _inVehicle): {

				// Current Laser Position in ASL
				FF_SimpleGrid_laserPos = getPosASL ((vehicle player) laserTarget ((vehicle player) unitTurret (player)));

				// List of Magazines for the Current Turret the player occupies and if it has a Laser
				_turretHasLaser = (((vehicle player) magazinesTurret ((vehicle player) unitTurret (player))) findIf {_x in _laserBatteryProxies});

				_playerInFFV = (fullCrew vehicle player select 0 select 1) isEqualTo "turret";
				_playerHasLaser = (currentMagazine player) in _laserBatteryProxies;

				// Then we see if it's using Laser Batteries
				if (_turretHasLaser > -1 || _playerInFFV && _playerHasLaser) then {

					// Make the UI Show
					FF_SimpleGrid_InUI = true;

					// If the Laser is on
					if !(FF_SimpleGrid_laserPos isEqualTo [0,0,0]) then {
						FF_SimpleGrid_ObserverPos = (getPosASL vehicle player);
						FF_SimpleGrid_TargetHeight = (FF_SimpleGrid_laserPos select 2);
						true;
					} else {false};
				} else {
					// If we fail the condition
					FF_SimpleGrid_InUI = false;
				};

			};

			// When the player is using a Handheld
			case (_inSights && _hasBatteries): {
				FF_SimpleGrid_laserPos = (getPosASL laserTarget player);
				FF_SimpleGrid_InUI = true;

				// If the Laser is on
				if !(FF_SimpleGrid_laserPos isEqualTo [0,0,0]) then {
					FF_SimpleGrid_ObserverPos = (getPosASL player);
					FF_SimpleGrid_TargetHeight = (FF_SimpleGrid_laserPos select 2);
					true;
				} else {false};
			};

			// Defaults to False if none of the Conditions are met
			default {false};
		};
	};
};

// Main Loop to handle UI Changes
FF_SimpleGrid_DesignatorUI = [] spawn {

	while {true} do {
		sleep 0.1;

		// While we are inside of a View that should have the UI
		while {FF_SimpleGrid_InUI} do {

			sleep 0.1;

			// Disable Serialization
			disableSerialization;
			
			// Create the UI if it doesn't exist and Assign it to _ui
			_ui = uiNameSpace getVariable "FF_SimpleGrid_HUD";
			if (isNil "_ui") then {
				"FF_SimpleGrid_HUD" cutRsc ["FF_SimpleGrid_HUD", "PLAIN", -1, false];
			};
			_ui = uiNameSpace getVariable "FF_SimpleGrid_HUD";

			// We need to Grab the UI that Handles the Relative Marker
			_relative = uiNameSpace getVariable "FF_SimpleGrid_HUD_Relative";

			// We only want to Activate the UI when we are actually Using it
			if (isNil "_relative" && FF_SimpleGrid_Relative_B != 0) then {
				"FF_SimpleGrid_HUD_Relative" cutRsc ["FF_SimpleGrid_HUD_Relative", "PLAIN", -1, false];
			};
			_relative = uiNameSpace getVariable "FF_SimpleGrid_HUD_Relative";

			// Grab the Grid and create the Text
			_grid = [FF_SimpleGrid_laserPos] call FF_fnc_SimpleGrid_getGrid;
			
			// Defining Variables
			_10DigitTar = "----- -----";
			_8DigitTar = "----  ----";
			_10DigitObs = "----- -----";
			_8DigitObs = "----  ----";
			_obsHeight = "N/A";
			_tarHeight = "N/A";
			_dif = "N/A";

			// Format the Digits into a readable Grid if we were given a proper one
			if !(_grid == "0000000000") then {
				
				// Target Information
				_10DigitTar = format ["%1 %2", _grid select [0,5], _grid select [5,5]];
				_8DigitTar = format ["%1  %2", _grid select [0,4], _grid select [5,4]];
				_tarHeight = str(round(FF_SimpleGrid_TargetHeight));
				
				// Observer Information
				_gridObs = [FF_SimpleGrid_ObserverPos] call FF_fnc_SimpleGrid_getGrid;
				_10DigitObs = format ["%1 %2", _gridObs select [0,5], _gridObs select [5,5]];
				_8DigitObs = format ["%1  %2", _gridObs select [0,4], _gridObs select [5,4]];
				_obsHeight = str(round(FF_SimpleGrid_ObserverPos select 2));
				_dif = str(round (FF_SimpleGrid_TargetHeight - (FF_SimpleGrid_ObserverPos select 2)));
			};

			// Set the Coordinates
			(_ui displayCtrl 1002) ctrlSetText _10DigitTar;
			(_ui displayCtrl 1000) ctrlSetText _8DigitTar;
			(_ui displayCtrl 1007) ctrlSetText _10DigitObs;
			(_ui displayCtrl 1009) ctrlSetText _8DigitObs;

			// Setting the Height
			(_ui displayCtrl 1013) ctrlSetText _tarHeight;
			(_ui displayCtrl 1014) ctrlSetText _obsHeight;
			(_ui displayCtrl 1015) ctrlSetText _dif;

			// Set Marker Type and Colour
			(_ui displayCtrl 1018) ctrlSetText FF_SimpleGrid_MarkerName;
			(_ui displayCtrl 1019) ctrlSetText FF_SimpleGrid_MarkerColourName;

			// If the Relative Marker UI is Active we Process it's Information
			if (!isNil "_relative") then {
				// Handle the Relative Information
				(_relative displayCtrl 1000) ctrlSetText (format ["BEAR: %1", FF_SimpleGrid_Relative_B]);
				(_relative displayCtrl 1001) ctrlSetText (format ["DIST: %1", FF_SimpleGrid_Relative_R]);
			};

		};

		// Remove the UI as it shouldn't exist here
		if (!isNull (uiNameSpace getVariable "FF_SimpleGrid_HUD")) then {
			"FF_SimpleGrid_HUD" cutFadeOut 0;
			FF_SimpleGrid_laserPos = [0,0,0];
		};

		// Relative Marker Stuff, Same as Above, Remove it since it doesn't belong outside the UI		
		if (!isNull (uiNameSpace getVariable "FF_SimpleGrid_HUD_Relative")) then {
			"FF_SimpleGrid_HUD_Relative" cutFadeOut 0;
			FF_SimpleGrid_point1 = [0,0,0];
			FF_SimpleGrid_point2 = [0,0,0];
			FF_SimpleGrid_Relative_B = 0;
			FF_SimpleGrid_Relative_R = 0;
		};
		

	};
};
};